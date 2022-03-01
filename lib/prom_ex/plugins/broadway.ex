if Code.ensure_loaded?(Broadway) do
  defmodule PromEx.Plugins.Broadway do
    @moduledoc """
    This plugin captures metrics emitted by Broadway.

    This plugin exposes the following metric groups:
    - `:broadway_init_event_metrics`
    - `:broadway_message_event_metrics`
    - `:broadway_batch_event_metrics`

    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          PromEx.Plugins.Broadway
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "broadway.json"}
        ]
      end
    end
    ```

    To correctly capture per-message metrics and error rate, add the following transform to your pipeline:
    ```
    defmodule WebApp.MyPipeline do
      use Broadway

      alias Broadway.Message

      def start_link(_opts) do
        Broadway.start_link(__MODULE__,
          name: __MODULE__,
          producer: [
            ...
            transformer: {__MODULE__, :transform, []}
          ]
        )
      end

      def transform(event, _opts) do
        %Message{
          data: event,
          acknowledger: {__MODULE__, :ack_id, :ack_data}
        }
      end
    end
    ```
    """

    use PromEx.Plugin

    require Logger

    alias Broadway.{BatchInfo, Message, Options}
    alias PromEx.Utils

    @millisecond_duration_buckets [10, 100, 500, 1_000, 10_000, 30_000, 60_000]
    @message_batch_size_buckets [1, 5, 10, 20, 50, 100]

    @init_topology_event [:broadway, :topology, :init]
    @message_stop_event [:broadway, :processor, :message, :stop]
    @message_exception_event [:broadway, :processor, :message, :exception]
    @batch_stop_event [:broadway, :batch_processor, :stop]

    @init_topology_processors_proxy_event [:prom_ex, :broadway, :proxy, :processor, :init]
    @init_topology_batchers_proxy_event [:prom_ex, :broadway, :proxy, :batcher, :init]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :broadway))

      # Telemetry metrics will emit warnings if multiple handlers with the same names are defined.
      # As a result, this plugin supports gathering metrics on multiple processors and batches, but needs
      # to proxy them as not to create multiple definitions of the same metrics. The final data point will
      # have a label for the module associated with the event though so you'll be able to separate one
      # measurement from another.
      set_up_telemetry_proxies(@init_topology_event, otp_app)

      # Event metrics definitions
      [
        topology_init_events(metric_prefix),
        handle_message_events(metric_prefix),
        handle_batch_events(metric_prefix)
      ]
    end

    defp topology_init_events(metric_prefix) do
      Event.build(
        :broadway_init_event_metrics,
        [
          last_value(
            metric_prefix ++ [:init, :status, :info],
            event_name: @init_topology_event,
            measurement: fn _measurements -> 1 end,
            description: "The topology configuration data that was provided to Broadway.",
            tags: [:name],
            tag_values: &extract_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:init, :hibernate_after, :default, :milliseconds],
            event_name: @init_topology_event,
            description: "The Broadway supervisor's hibernate after default value.",
            measurement: extract_default_config_measurement(:hibernate_after),
            tags: [:name],
            tag_values: &extract_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:init, :resubscribe_interval, :default, :milliseconds],
            event_name: @init_topology_event,
            description: "The Broadway supervisor's resubscribe interval default value.",
            measurement: extract_default_config_measurement(:resubscribe_interval),
            tags: [:name],
            tag_values: &extract_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:init, :max, :duration, :default, :milliseconds],
            event_name: @init_topology_event,
            description: "The Broadway supervisor's max seconds default value (in milliseconds).",
            measurement: extract_default_config_measurement(:max_seconds),
            tags: [:name],
            tag_values: &extract_init_tag_values/1,
            unit: {:second, :millisecond}
          ),
          last_value(
            metric_prefix ++ [:init, :max_restarts, :default, :value],
            event_name: @init_topology_event,
            description: "The Broadway supervisor's max restarts default value.",
            measurement: extract_default_config_measurement(:max_restarts),
            tags: [:name],
            tag_values: &extract_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:init, :shutdown, :default, :milliseconds],
            event_name: @init_topology_event,
            description: "The Broadway supervisor's shutdown default value.",
            measurement: extract_default_config_measurement(:shutdown),
            tags: [:name],
            tag_values: &extract_init_tag_values/1
          ),
          last_value(
            metric_prefix ++ [:init, :processor, :hibernate_after, :milliseconds],
            event_name: @init_topology_processors_proxy_event,
            description: "The Broadway processors hibernate after value.",
            measurement: fn _measurements, %{hibernate_after: hibernate_after} -> hibernate_after end,
            tags: [:name, :processor]
          ),
          last_value(
            metric_prefix ++ [:init, :processor, :max_demand, :value],
            event_name: @init_topology_processors_proxy_event,
            description: "The Broadway processors max demand value.",
            measurement: fn _measurements, %{max_demand: max_demand} -> max_demand end,
            tags: [:name, :processor]
          ),
          last_value(
            metric_prefix ++ [:init, :processor, :concurrency, :value],
            event_name: @init_topology_processors_proxy_event,
            description: "The Broadway processors concurrency value.",
            measurement: fn _measurements, %{concurrency: concurrency} -> concurrency end,
            tags: [:name, :processor]
          ),
          last_value(
            metric_prefix ++ [:init, :batcher, :hibernate_after, :milliseconds],
            event_name: @init_topology_batchers_proxy_event,
            description: "The Broadway batchers hibernate after value.",
            measurement: fn _measurements, %{hibernate_after: hibernate_after} -> hibernate_after end,
            tags: [:name, :batcher]
          ),
          last_value(
            metric_prefix ++ [:init, :batcher, :concurrency, :value],
            event_name: @init_topology_batchers_proxy_event,
            description: "The Broadway batchers concurrency value.",
            measurement: fn _measurements, %{concurrency: concurrency} -> concurrency end,
            tags: [:name, :batcher]
          ),
          last_value(
            metric_prefix ++ [:init, :batcher, :batch_size, :value],
            event_name: @init_topology_batchers_proxy_event,
            description: "The Broadway batchers batch size value.",
            measurement: fn _measurements, %{batch_size: batch_size} -> batch_size end,
            tags: [:name, :batcher]
          ),
          last_value(
            metric_prefix ++ [:init, :batcher, :batch_timeout, :milliseconds],
            event_name: @init_topology_batchers_proxy_event,
            description: "The Broadway batchers timeout value.",
            measurement: fn _measurements, %{batch_timeout: batch_timeout} -> batch_timeout end,
            tags: [:name, :batcher]
          )
        ]
      )
    end

    @doc false
    def proxy_broadway_init_event(_event_name, _measurements, %{config: config}, _config) do
      # Invoking Broadway module
      broadway_module =
        config
        |> Keyword.fetch!(:name)
        |> Utils.normalize_module_name()

      # Extract all of the processors and proxy for each processor
      config
      |> Keyword.get(:processors, [])
      |> Enum.each(fn {processor, processor_options} ->
        metadata =
          processor_options
          |> Map.new()
          |> Map.put(:processor, processor)
          |> Map.put(:name, broadway_module)

        :telemetry.execute(@init_topology_processors_proxy_event, %{}, metadata)
      end)

      # Extract all of the batchers and proxy for each batcher
      config
      |> Keyword.get(:batchers, [])
      |> Enum.each(fn {batcher, batcher_options} ->
        metadata =
          batcher_options
          |> Map.new()
          |> Map.put(:batcher, batcher)
          |> Map.put(:name, broadway_module)

        :telemetry.execute(@init_topology_batchers_proxy_event, %{}, metadata)
      end)
    end

    defp set_up_telemetry_proxies(init_topology_event, otp_app) do
      :telemetry.attach(
        [:prom_ex, :broadway, :proxy, otp_app],
        init_topology_event,
        &__MODULE__.proxy_broadway_init_event/4,
        %{}
      )
    end

    defp extract_default_config_measurement(field) do
      fn _measurements, %{config: config} ->
        config
        |> NimbleOptions.validate!(Options.definition())
        |> Map.new()
        |> Map.get(field)
      end
    end

    defp handle_message_events(metric_prefix) do
      Event.build(
        :broadway_message_event_metrics,
        [
          distribution(
            metric_prefix ++ [:process, :message, :duration, :milliseconds],
            event_name: @message_stop_event,
            measurement: :duration,
            description: "The time it takes Broadway to process a message.",
            reporter_options: [
              buckets: @millisecond_duration_buckets
            ],
            tags: [:processor_key, :name],
            tag_values: fn %{processor_key: processor_key, message: %Message{acknowledger: {acknowledger, _, _}}} ->
              %{
                processor_key: processor_key,
                name: Utils.normalize_module_name(acknowledger)
              }
            end,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:process, :message, :exception, :duration, :milliseconds],
            event_name: @message_exception_event,
            measurement: :duration,
            description: "The time it takes Broadway to process a message that results in an error.",
            reporter_options: [
              buckets: @millisecond_duration_buckets
            ],
            tags: [:processor_key, :name, :kind, :reason],
            tag_values: &extract_exception_tag_values/1,
            unit: {:native, :millisecond}
          )
        ]
      )
    end

    defp handle_batch_events(metric_prefix) do
      Event.build(
        :broadway_batch_event_metrics,
        [
          distribution(
            metric_prefix ++ [:process, :batch, :duration, :milliseconds],
            event_name: @batch_stop_event,
            measurement: :duration,
            description: "The time it takes Broadway to process a batch of messages.",
            reporter_options: [
              buckets: @millisecond_duration_buckets
            ],
            tags: [:batcher, :name],
            tag_values: &extract_batcher_tag_values/1,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:process, :batch, :failure, :size],
            event_name: @batch_stop_event,
            measurement: fn _measurements, metadata ->
              length(metadata.failed_messages)
            end,
            description: "How many of the messages in the batch failed to process.",
            reporter_options: [
              buckets: @message_batch_size_buckets
            ],
            tags: [:batcher, :name],
            tag_values: &extract_batcher_tag_values/1
          ),
          distribution(
            metric_prefix ++ [:process, :batch, :success, :size],
            event_name: @batch_stop_event,
            measurement: fn _measurements, metadata ->
              length(metadata.successful_messages)
            end,
            description: "How many of the messages in the batch were successfully processed.",
            reporter_options: [
              buckets: @message_batch_size_buckets
            ],
            tags: [:batcher, :name],
            tag_values: &extract_batcher_tag_values/1
          )
        ]
      )
    end

    defp extract_batcher_tag_values(%{batch_info: batch_info = %BatchInfo{}, topology_name: name}) do
      %{
        name: Utils.normalize_module_name(name),
        batch_key: batch_info.batch_key,
        batcher: batch_info.batcher
      }
    end

    defp extract_init_tag_values(metadata) do
      full_configuration =
        metadata.config
        |> NimbleOptions.validate!(Broadway.Options.definition())
        |> Map.new()

      %{
        name: Utils.normalize_module_name(full_configuration.name)
      }
    end

    defp extract_exception_tag_values(%{
           processor_key: processor_key,
           kind: kind,
           reason: reason,
           stacktrace: stacktrace,
           message: %Message{acknowledger: {acknowledger, _, _}}
         }) do
      reason = Utils.normalize_exception(kind, reason, stacktrace)

      %{
        processor_key: processor_key,
        kind: kind,
        reason: reason,
        name: Utils.normalize_module_name(acknowledger)
      }
    end
  end
else
  defmodule PromEx.Plugins.Broadway do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Broadway")
    end
  end
end
