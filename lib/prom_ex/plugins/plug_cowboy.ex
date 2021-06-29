if Code.ensure_loaded?(Plug.Cowboy) do
  defmodule PromEx.Plugins.PlugCowboy do
    @moduledoc """
    This plugin captures HTTP request metrics emitted by Plug.Cowboy.

    This plugin exposes the following metric group:
    - `:plug_cowboy_http_event_metrics`


    To use plugin in your application, add the following to your PromEx module:
    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          PromEx.Plugins.PlugCowboy
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "plug_cowboy.json"}
        ]
      end
    end
    ```
    """

    use PromEx.Plugin
    require Logger

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = PromEx.metric_prefix(otp_app, :plug_cowboy)

      [
        http_events(metric_prefix, opts)
      ]
    end

    defp http_events(metrics_prefix, opts) do
      # Shared configuration
      cowboy_stop_event = [:cowboy, :request, :stop]
      http_metrics_tags = [:status, :method, :path, :controller, :action]

      Event.build(
        :plug_cowboy_http_event_metrics,
        [
          # Capture request duration information
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: cowboy_stop_event,
            measurement: :duration,
            description: "The time it takes for the application to respond to HTTP requests.",
            reporter_options: [
              buckets: exponential!(1, 2, 12)
            ],
            tag_values: &get_tags/1,
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),

          # Capture response payload size information
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: cowboy_stop_event,
            measurement: :resp_body_length,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: exponential!(1, 4, 12)
            ],
            tag_values: &get_tags/1,
            tags: http_metrics_tags,
            unit: :byte
          ),

          # Capture the number of requests that have been serviced
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: cowboy_stop_event,
            description: "The number of requests have been serviced.",
            tag_values: &get_tags/1,
            tags: http_metrics_tags
          )
        ]
      )
    end

    defp get_tags(%{resp_status: resp_status, req: %{method: method, path: path}}) do
      case get_http_status(resp_status) do
        status when is_binary(status) ->
          %{
            status: status,
            method: method,
            path: path
          }

        :undefined ->
          %{
            status: :undefined,
            method: method,
            path: path
          }

        nil ->
          Logger.warn("Cowboy failed to provide valid response status #{inspect(resp_status)}")
          %{}
      end
    end

    defp get_http_status(resp_status) when is_integer(resp_status) do
      to_string(resp_status)
    end
  else
    defmodule PromEx.Plugins.PlugCowboy do
      @moduledoc false
      use PromEx.Plugin

      @impl true
      def event_metrics(_opts) do
        PromEx.Plugin.no_dep_raise(__MODULE__, "Plug.Cowboy")
      end
    end
  end
end
