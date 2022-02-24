if Code.ensure_loaded?(Oban) do
  defmodule PromEx.Plugins.Oban do
    @moduledoc """
    This plugin captures metrics emitted by Oban. Specifically, it captures metrics from job events, producer events,
    and also from internal polling jobs to monitor queue sizes

    This plugin supports the following options:
    - `oban_supervisors`: This is an OPTIONAL option and it allows you to specify what Oban instances should have their events
      tracked. By default the only Oban instance that will have its events tracked is the default `Oban` instance. As a result, by
      default this option has a value of `[Oban]`. If you would like to track other named Oban instances, or perhaps your default
      and only Oban instance has a different name, you can pass in your own list of Oban instances (e.g. `[Oban, Oban.PrivateJobs]`).

    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :oban]`. If this changes you will also want to set `oban_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `oban_metric_prefix` is `{otp_app}_prom_ex_oban`.

    - `poll_rate`: This option is OPTIONAL and is the rate at which poll metrics are refreshed (default is 5 seconds).

    This plugin exposes the following metric groups:
    - `:oban_init_event_metrics`
    - `:oban_job_event_metrics`
    - `:oban_producer_event_metrics`
    - `:oban_circuit_event_metrics`
    - `:oban_queue_poll_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          {PromEx.Plugins.Oban, oban_supervisors: [Oban, Oban.AnotherSupervisor], poll_rate: 10_000}
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "oban.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin

    import Ecto.Query, only: [group_by: 3, select: 3]

    # Oban events
    @init_event [:oban, :supervisor, :init]
    @job_complete_event [:oban, :job, :stop]
    @job_exception_event [:oban, :job, :exception]
    @producer_complete_event [:oban, :producer, :stop]
    @producer_exception_event [:oban, :producer, :exception]
    @circuit_breaker_trip_event [:oban, :circuit, :trip]
    @circuit_breaker_open_event [:oban, :circuit, :open]

    # PromEx Oban proxy events
    @init_event_queue_limit_proxy [:prom_ex, :oban, :queue, :limit, :proxy]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :oban))

      oban_supervisors = get_oban_supervisors(opts)
      keep_function_filter = keep_oban_instance_metrics(oban_supervisors)

      # Set up event proxies
      set_up_init_proxy_event(metric_prefix)

      [
        oban_supervisor_init_event_metrics(metric_prefix, keep_function_filter),
        oban_job_event_metrics(metric_prefix, keep_function_filter),
        oban_producer_event_metrics(metric_prefix, keep_function_filter),
        oban_circuit_breaker_event_metrics(metric_prefix, keep_function_filter)
      ]
    end

    @impl true
    def polling_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :oban))
      poll_rate = Keyword.get(opts, :poll_rate, 5_000)

      oban_supervisors = get_oban_supervisors(opts)

      # Queue length details
      Polling.build(
        :oban_queue_poll_metrics,
        poll_rate,
        {__MODULE__, :execute_queue_metrics, [oban_supervisors]},
        [
          last_value(
            metric_prefix ++ [:queue, :length, :count],
            event_name: [:prom_ex, :plugin, :oban, :queue, :length, :count],
            description: "The total number jobs that are in the queue in the designated state",
            measurement: :count,
            tags: [:name, :queue, :state]
          )
        ]
      )
    end

    @doc false
    def execute_queue_metrics(oban_supervisors) do
      oban_supervisors
      |> Enum.each(fn oban_supervisor ->
        oban_supervisor
        |> Oban.Registry.whereis()
        |> case do
          oban_pid when is_pid(oban_pid) ->
            config = Oban.Registry.config(oban_supervisor)
            handle_oban_queue_polling_metrics(oban_supervisor, config)

          _ ->
            :skip
        end
      end)
    end

    def oban_circuit_breaker_event_metrics(metric_prefix, keep_function_filter) do
      Event.build(
        :oban_circuit_breaker_event_metrics,
        [
          counter(
            metric_prefix ++ [:circuit, :trip, :total],
            event_name: @circuit_breaker_trip_event,
            description: "The number of circuit breaker events that have occurred",
            tag_values: &circuit_breaker_trip_tag_values/1,
            tags: [:name, :circuit_breaker],
            keep: keep_function_filter
          ),
          counter(
            metric_prefix ++ [:circuit, :open, :total],
            event_name: @circuit_breaker_open_event,
            description: "The number of circuit open events that have occurred.",
            tag_values: &circuit_breaker_trip_tag_values/1,
            tags: [:name, :circuit_breaker],
            keep: keep_function_filter
          )
        ]
      )
    end

    @doc false
    def handle_proxy_init_event(_event_name, _event_measurement, event_metadata, _config) do
      Enum.each(event_metadata.conf.queues, fn {queue, queue_opts} ->
        limit = Keyword.get(queue_opts, :limit, 0)

        metadata = %{
          queue: queue,
          name: event_metadata.conf.name
        }

        :telemetry.execute(@init_event_queue_limit_proxy, %{limit: limit}, metadata)
      end)
    end

    defp circuit_breaker_trip_tag_values(%{name: name, config: conf}) do
      %{
        name: normalize_module_name(conf.name),
        circuit_breaker: normalize_module_name(name)
      }
    end

    defp circuit_breaker_trip_tag_values(%{name: name, conf: conf}) do
      %{
        name: normalize_module_name(conf.name),
        circuit_breaker: normalize_module_name(name)
      }
    end

    defp oban_job_event_metrics(metric_prefix, keep_function_filter) do
      job_attempt_buckets = [1, 5, 10]
      job_duration_buckets = [10, 100, 500, 1_000, 5_000, 20_000]

      Event.build(
        :oban_job_event_metrics,
        [
          distribution(
            metric_prefix ++ [:job, :processing, :duration, :milliseconds],
            event_name: @job_complete_event,
            measurement: :duration,
            description: "The amount of time it takes to processes an Oban job.",
            reporter_options: [
              buckets: job_duration_buckets
            ],
            tag_values: &job_complete_tag_values/1,
            tags: [:name, :queue, :state, :worker],
            unit: {:native, :millisecond},
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:job, :queue, :time, :milliseconds],
            event_name: @job_complete_event,
            measurement: :queue_time,
            description: "The amount of time that the Oban job was waiting in queue for processing.",
            reporter_options: [
              buckets: job_duration_buckets
            ],
            tag_values: &job_complete_tag_values/1,
            tags: [:name, :queue, :state, :worker],
            unit: {:native, :millisecond},
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:job, :complete, :attempts],
            event_name: @job_complete_event,
            measurement: fn _measurement, %{attempt: attempt} ->
              attempt
            end,
            description: "The number of times a job was attempted prior to completing.",
            reporter_options: [
              buckets: job_attempt_buckets
            ],
            tag_values: &job_complete_tag_values/1,
            tags: [:name, :queue, :state, :worker],
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:job, :exception, :duration, :milliseconds],
            event_name: @job_exception_event,
            measurement: :duration,
            description: "The amount of time it took to process a job the encountered an exception.",
            reporter_options: [
              buckets: job_duration_buckets
            ],
            tag_values: &job_exception_tag_values/1,
            tags: [:name, :queue, :state, :worker, :kind, :error],
            unit: {:native, :millisecond},
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:job, :exception, :queue, :time, :milliseconds],
            event_name: @job_exception_event,
            measurement: :queue_time,
            description:
              "The amount of time that the Oban job was waiting in queue for processing prior to resulting in an exception.",
            reporter_options: [
              buckets: job_duration_buckets
            ],
            tag_values: &job_exception_tag_values/1,
            tags: [:name, :queue, :state, :worker, :kind, :error],
            unit: {:native, :millisecond},
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:job, :exception, :attempts],
            event_name: @job_exception_event,
            measurement: fn _measurement, %{attempt: attempt} ->
              attempt
            end,
            description: "The number of times a job was attempted prior to throwing an exception.",
            reporter_options: [
              buckets: job_attempt_buckets
            ],
            tag_values: &job_exception_tag_values/1,
            tags: [:name, :queue, :state, :worker],
            keep: keep_function_filter
          )
        ]
      )
    end

    defp oban_producer_event_metrics(metric_prefix, keep_function_filter) do
      Event.build(
        :oban_producer_event_metrics,
        [
          distribution(
            metric_prefix ++ [:producer, :duration, :milliseconds],
            event_name: @producer_complete_event,
            measurement: :duration,
            description: "How long it took to dispatch the job.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000]
            ],
            unit: {:native, :millisecond},
            tag_values: &producer_tag_values/1,
            tags: [:queue, :name],
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:producer, :dispatched, :count],
            event_name: @producer_complete_event,
            measurement: fn _measurement, %{dispatched_count: count} ->
              count
            end,
            description: "The number of jobs that were dispatched.",
            reporter_options: [
              buckets: [5, 10, 50, 100]
            ],
            tag_values: &producer_tag_values/1,
            tags: [:queue, :name],
            keep: keep_function_filter
          ),
          distribution(
            metric_prefix ++ [:producer, :exception, :duration, :milliseconds],
            event_name: @producer_exception_event,
            measurement: :duration,
            description: "How long it took for the producer to raise an exception.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000]
            ],
            unit: {:native, :millisecond},
            tag_values: &producer_tag_values/1,
            tags: [:queue, :name],
            keep: keep_function_filter
          )
        ]
      )
    end

    defp job_complete_tag_values(metadata) do
      config =
        case metadata do
          %{config: config} ->
            config

          %{conf: config} ->
            config
        end

      %{
        name: normalize_module_name(config.name),
        queue: metadata.job.queue,
        state: metadata.state,
        worker: metadata.worker
      }
    end

    defp job_exception_tag_values(metadata) do
      error =
        case metadata.error do
          %error_type{} -> normalize_module_name(error_type)
          _ -> "Undefined"
        end

      config =
        case metadata do
          %{config: config} ->
            config

          %{conf: config} ->
            config
        end

      %{
        name: normalize_module_name(config.name),
        queue: metadata.job.queue,
        state: metadata.state,
        worker: metadata.worker,
        kind: metadata.kind,
        error: error
      }
    end

    defp producer_tag_values(metadata) do
      %{
        queue: metadata.queue,
        name: normalize_module_name(metadata.conf.name)
      }
    end

    defp oban_supervisor_init_event_metrics(metric_prefix, keep_function_filter) do
      Event.build(
        :oban_init_event_metrics,
        [
          last_value(
            metric_prefix ++ [:init, :status, :info],
            event_name: @init_event,
            description: "Information regarding the initialized oban supervisor.",
            measurement: fn _measurements -> 1 end,
            tags: [:name, :node, :plugins, :prefix, :queues, :repo],
            tag_values: &oban_init_tag_values/1,
            keep: keep_function_filter
          ),
          last_value(
            metric_prefix ++ [:init, :shutdown, :grace, :period, :milliseconds],
            event_name: @init_event,
            description: "The Oban supervisor's shutdown grace period value.",
            measurement: fn _measurements, %{conf: config} ->
              config.shutdown_grace_period
            end,
            tags: [:name],
            tag_values: &oban_init_tag_values/1,
            keep: keep_function_filter
          ),
          last_value(
            metric_prefix ++ [:init, :dispatch, :cooldown, :milliseconds],
            event_name: @init_event,
            description: "The Oban supervisor's dispatch cooldown value.",
            measurement: fn _measurements, %{conf: config} ->
              config.dispatch_cooldown
            end,
            tags: [:name],
            tag_values: &oban_init_tag_values/1,
            keep: keep_function_filter
          ),
          last_value(
            metric_prefix ++ [:init, :queue, :concurrency, :limit],
            event_name: @init_event_queue_limit_proxy,
            description: "The concurrency limits of each of the Oban queue.",
            measurement: :limit,
            tags: [:name, :queue],
            tag_values: &oban_init_queues_tag_values/1,
            keep: keep_function_filter
          )
        ]
      )
    end

    defp handle_oban_queue_polling_metrics(oban_supervisor, config) do
      query =
        Oban.Job
        |> group_by([j], [j.queue, j.state])
        |> select([j], {j.queue, j.state, count(j.id)})

      config
      |> Oban.Repo.all(query)
      |> Enum.each(fn {queue, state, count} ->
        measurements = %{count: count}
        metadata = %{name: normalize_module_name(oban_supervisor), queue: queue, state: state}

        :telemetry.execute([:prom_ex, :plugin, :oban, :queue, :length, :count], measurements, metadata)
      end)
    end

    defp get_oban_supervisors(opts) do
      opts
      |> Keyword.get(:oban_supervisors, [Oban])
      |> case do
        supervisors when is_list(supervisors) ->
          MapSet.new(supervisors)

        _ ->
          raise "Invalid :oban_supervisors option value."
      end
    end

    defp keep_oban_instance_metrics(oban_supervisors) do
      fn
        %{conf: %{name: name}} ->
          MapSet.member?(oban_supervisors, name)

        %{name: name} ->
          MapSet.member?(oban_supervisors, name)

        _ ->
          false
      end
    end

    defp oban_init_tag_values(%{conf: config}) do
      plugins_string_list =
        config.plugins
        |> Enum.map_join(", ", fn plugin ->
          normalize_module_name(plugin)
        end)

      queues_string_list =
        config.queues
        |> Enum.map_join(", ", fn {queue, _queue_opts} ->
          Atom.to_string(queue)
        end)

      %{
        name: normalize_module_name(config.name),
        node: config.node,
        plugins: plugins_string_list,
        prefix: config.prefix,
        queues: queues_string_list,
        repo: normalize_module_name(config.repo)
      }
    end

    defp oban_init_queues_tag_values(%{name: name, queue: queue}) do
      %{
        name: normalize_module_name(name),
        queue: queue
      }
    end

    defp set_up_init_proxy_event(prefix) do
      :telemetry.attach(
        [:prom_ex, :oban, :proxy] ++ prefix,
        @init_event,
        &__MODULE__.handle_proxy_init_event/4,
        %{}
      )
    end

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name({name, _options}), do: normalize_module_name(name)

    defp normalize_module_name(name), do: name
  end
else
  defmodule PromEx.Plugins.Oban do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Oban")
    end
  end
end
