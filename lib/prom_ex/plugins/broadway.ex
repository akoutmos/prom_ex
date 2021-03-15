if Code.ensure_loaded?(Broadway) do
  defmodule PromEx.Plugins.Broadway do
    @moduledoc """
    This plugin captures metrics emitted by Broadway.

    This plugin supports the following options:
    - `placeholder`: This is a placeholder

    This plugin exposes the following metric groups:
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

    @message_stop_event [:broadway, :processor, :message, :stop]
    @message_exception_event [:broadway, :processor, :message, :exception]
    @batch_stop_event [:broadway, :consumer, :stop]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :broadway)

      # Event metrics definitions
      [
        handle_message_events(metric_prefix),
        handle_batch_events(metric_prefix)
      ]
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
            unit: {:native, :millisecond}
          )
        ]
      )
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
