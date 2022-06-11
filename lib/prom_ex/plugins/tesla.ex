if Code.ensure_loaded?(Tesla) do
  defmodule PromEx.Plugins.Tesla do
    @moduledoc """
    This plugin captures HTTP request metrics emitted by Tesla.

    This plugin exposes the following metric group:
    - `:tesla_http_event_metrics`

    This plugin supports the following options:
    - `otp_app`: This is a REQUIRED option and is the name of you application in snake case (e.g. :my_cool_app).

    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :application]`. If this changes you will also want to set `application_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `application_metric_prefix` is `{otp_app}_prom_ex_application`.



    To use plugin in your application, add the following to your PromEx module:

    ```
    defmodule WebApp.PromEx do
      use PromEx, otp_app: :web_app

      @impl true
      def plugins do
        [
          ...
          PromEx.Plugins.Tesla
        ]
      end

      @impl true
      def dashboards do
        [
          ...
          {:prom_ex, "tesla.json"}
        ]
      end
    end
    ```


    """

    use PromEx.Plugin

    require Logger

    # @start_event [:tesla, :request, :start]
    @stop_event [:tesla, :request, :stop]
    @exception_event [:tesla, :request, :exception]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :tesla))

      [
        http_events(metric_prefix, opts)
      ]
    end

    defp http_events(metric_prefix, _opts) do
      http_metrics_tags = [:status, :method, :url]

      Event.build(
        :tesla_http_event_metrics,
        [
          distribution(
            metric_prefix ++ [:http, :request, :duration, :milliseconds],
            event_name: @stop_event,
            measurement: :duration,
            description: "The time it takes for an HTTP request to complete.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:http, :request, :exception, :duration, :milliseconds],
            event_name: @exception_event,
            measurement: :duration,
            description: "The time it takes for an HTTP request to result in an exception.",
            reporter_options: [
              buckets: [10, 100, 500, 1_000, 5_000, 10_000, 30_000]
            ],
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: {:native, :millisecond}
          ),
          distribution(
            metric_prefix ++ [:http, :response, :size, :bytes],
            event_name: @stop_event,
            description: "The size of the HTTP response payload.",
            reporter_options: [
              buckets: [64, 512, 4_096, 65_536, 262_144, 1_048_576, 4_194_304, 16_777_216]
            ],
            measurement: &resp_body_size/2,
            tag_values: &get_tags(&1),
            tags: http_metrics_tags,
            unit: :byte
          ),
          counter(
            metric_prefix ++ [:http, :requests, :total],
            event_name: @stop_event,
            description: "The number of requests that have been made.",
            tag_values: &get_tags(&1),
            tags: http_metrics_tags
          )
        ]
      )
    end

    defp get_tags(%{env: %Tesla.Env{status: status, method: method, url: url}}) do
      %{
        status: status,
        method: method,
        url: url
      }
    end

    defp resp_body_size(_, metadata) do
      case metadata.env.body do
        nil -> 0
        _ -> metadata.env.body |> :erlang.term_to_binary() |> :erlang.byte_size()
      end
    end
  end
else
  defmodule PromEx.Plugins.Tesla do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts) do
      PromEx.Plugin.no_dep_raise(__MODULE__, "Tesla")
    end
  end
end
