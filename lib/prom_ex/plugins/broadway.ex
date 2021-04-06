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
            tag_values: fn %{config: config_opts} ->
              full_configuration = NimbleOptions.validate!(config_opts, Broadway.Options.definition()) |> IO.inspect()

              %{}
            end
          )
        ]
      )
    end

    """
    %{
      message: %Broadway.Message{
        acknowledger: {WebApp.TempProcessor, :ack_id, :ack_data},
        batch_key: :default,
        batch_mode: :bulk,
        batcher: :default,
        data: :ok,
        metadata: %{},
        status: :ok
      },
      name: WebApp.TempProcessor.Broadway.Processor_default_4,
      processor_key: :default
    }
    """

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
          # TODO: Add batch sizes for failed and success
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
