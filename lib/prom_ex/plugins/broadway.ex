if Code.ensure_loaded?(Broadway) do
  defmodule PromEx.Plugins.Broadway do
    @moduledoc """
    This plugin captures metrics emitted by Broadway.

    This plugin supports the following options:
    - `placeholder`: This is a placeholder

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
    """

    use PromEx.Plugin

    require Logger

    alias Broadway.{BatchInfo, Message}

    @init_topology_event [:broadway, :topology, :init]
    @message_stop_event [:broadway, :processor, :message, :stop]
    @message_exception_event [:broadway, :processor, :message, :exception]
    @batch_stop_event [:broadway, :consumer, :stop]

    @init_topology_processors_proxy_event [:prom_ex, :broadway, :proxy, :processor, :init]
    @init_topology_batchers_proxy_event [:prom_ex, :broadway, :proxy, :batcher, :init]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :broadway)

      # Event metrics definitions
      [
        topology_init_events(metric_prefix),
        handle_message_events(metric_prefix),
        handle_batch_events(metric_prefix)
      ]
    end

    """
    [
      hibernate_after: 15000,
      context: :context_not_set,
      resubscribe_interval: 100,
      max_seconds: 5,
      max_restarts: 3,
      shutdown: 30000,
      name: WebApp.TempProcessor,
      producer: [
        hibernate_after: 15000,
        concurrency: 1,
        module: {WebApp.CityProducer, []},
        transformer: {WebApp.TempProcessor, :transform, []},
        rate_limiting: [allowed_messages: 60, interval: 30000]
      ],
      processors: [
        default: [hibernate_after: 15000, max_demand: 10, concurrency: 5]
      ],
      batchers: [
        batch_temp: [
          hibernate_after: 15000,
          concurrency: 2,
          batch_size: 15,
          batch_timeout: 15000
        ]
      ]
    ]
    """

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
          )
        ]
      )
    end

    defp extract_default_config_measurement(field) do
      fn _measurements, %{config: config} ->
        config
        |> NimbleOptions.validate!(Broadway.Options.definition())
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
              buckets: exponential!(1, 2, 12)
            ],
            tags: [:processor_key, :acknowledger],
            tag_values: fn %{processor_key: processor_key, message: %Message{acknowledger: {acknowledger, _, _}}} ->
              %{
                processor_key: processor_key,
                acknowledger: normalize_module_name(acknowledger)
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
              buckets: exponential!(1, 2, 12)
            ],
            tags: [:processor_key, :acknowledger, :kind, :reason],
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
              buckets: exponential!(1, 2, 12)
            ],
            tags: [:batch_key, :batcher],
            tag_values: fn metadata ->
              %{
                batch_key: metadata.batch_info.batch_key,
                batcher: metadata.batch_info.batcher
              }
            end,
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
              buckets: [1, 3, 5, 10, 20, 50, 100]
            ],
            tags: [:batch_key, :batcher],
            tag_values: fn metadata ->
              %{
                batch_key: metadata.batch_info.batch_key,
                batcher: metadata.batch_info.batcher
              }
            end
          ),
          distribution(
            metric_prefix ++ [:process, :batch, :success, :size],
            event_name: @batch_stop_event,
            measurement: fn _measurements, metadata ->
              length(metadata.successful_messages)
            end,
            description: "How many of the messages in the batch were successfully processed.",
            reporter_options: [
              buckets: [1, 3, 5, 10, 20, 50, 100]
            ],
            tags: [:batch_key, :batcher],
            tag_values: fn metadata ->
              %{
                batch_key: metadata.batch_info.batch_key,
                batcher: metadata.batch_info.batcher
              }
            end
          )
        ]
      )
    end

    defp extract_init_tag_values(metadata) do
      full_configuration =
        metadata.config
        |> NimbleOptions.validate!(Broadway.Options.definition())
        |> Map.new()

      %{
        name: normalize_module_name(full_configuration.name)
      }
    end

    defp extract_exception_tag_values(%{
           processor_key: processor_key,
           kind: kind,
           reason: reason,
           message: %Message{acknowledger: {acknowledger, _, _}}
         }) do
      %{
        processor_key: processor_key,
        kind: kind,
        reason: normalize_exception_reason(reason),
        acknowledger: normalize_module_name(acknowledger)
      }
    end

    defp normalize_exception_reason(reason) when is_struct(reason) do
      normalize_exception_reason(reason.__struct__)
    end

    defp normalize_exception_reason(reason) when is_atom(reason) do
      reason
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name) when is_atom(name) do
      name
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
    end

    defp normalize_module_name(name), do: name
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
