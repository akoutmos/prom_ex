if Code.ensure_loaded?(Finch) do
  defmodule PromEx.Plugins.Finch do
    @moduledoc """
    This plugin captures metrics emitted by Finch. Finch is an HTTP client with a focus
    on performance, built on top of Mint and NimblePool.

    ## Plugin options

    This plugin supports the following options:
    - `metric_prefix`: This option is OPTIONAL and is used to override the default metric prefix of
      `[otp_app, :prom_ex, :finch]`. If this changes you will also want to set `finch_metric_prefix`
      in your `dashboard_assigns` to the snakecase version of your prefix, the default
      `finch_metric_prefix` is `{otp_app}_prom_ex_finch`.

    - `duration_unit`: This is an OPTIONAL option and is a `Telemetry.Metrics.time_unit()`. It can be one of:
      `:second | :millisecond | :microsecond | :nanosecond`. It is `:millisecond` by default.

    - `finch_instances`: This is an OPTIONAL option and is a list of Finch instance names (atoms) that you want
      to monitor. If not provided, all Finch instances will be monitored.

    This plugin exposes the following metric groups:
    - `:finch_request_event_metrics`
    - `:finch_queue_event_metrics`
    - `:finch_connection_event_metrics`
    - `:finch_send_event_metrics`

    To use plugin in your application, add the following to your PromEx module `plugins/0` function:
    ```elixir
    def plugins do
      [
        ...
        PromEx.Plugins.Finch
      ]
    end
    ```

    Or with custom options:
    ```elixir
    def plugins do
      [
        ...
        {PromEx.Plugins.Finch, finch_instances: [MyApp.Finch], duration_unit: :millisecond}
      ]
    end
    ```
    """

    use PromEx.Plugin

    @request_stop_event [:finch, :request, :stop]
    @request_exception_event [:finch, :request, :exception]

    @queue_stop_event [:finch, :queue, :stop]
    @queue_exception_event [:finch, :queue, :exception]

    @connect_start_event [:finch, :connect, :start]
    @connect_stop_event [:finch, :connect, :stop]

    @send_stop_event [:finch, :send, :stop]

    @impl true
    def event_metrics(opts) do
      otp_app = Keyword.fetch!(opts, :otp_app)
      metric_prefix = Keyword.get(opts, :metric_prefix, PromEx.metric_prefix(otp_app, :finch))
      duration_unit = Keyword.get(opts, :duration_unit, :millisecond)

      # Event metrics definitions
      [
        request_metrics(metric_prefix, duration_unit),
        queue_metrics(metric_prefix, duration_unit),
        connection_metrics(metric_prefix, duration_unit),
        send_metrics(metric_prefix, duration_unit)
      ]
    end

    defp request_metrics(metric_prefix, duration_unit) do
      duration_unit_plural = String.to_atom("#{duration_unit}s")

      Event.build(
        :finch_request_event_metrics,
        [
          # Track total requests by instance and result
          counter(
            metric_prefix ++ [:request, :count, :total],
            event_name: @request_stop_event,
            description: "Total number of Finch requests",
            tags: [:finch_name, :method, :scheme, :host, :port, :status],
            tag_values: &finch_request_tag_values/1
          ),

          # Track request duration
          distribution(
            metric_prefix ++ [:request, :duration, duration_unit_plural],
            event_name: @request_stop_event,
            measurement: :duration,
            description: "The time spent making the HTTP request",
            tags: [:finch_name, :method, :scheme, :host, :port, :status],
            tag_values: &finch_request_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 100, 250, 500, 1_000, 2_500, 5_000, 10_000]
            ],
            unit: {:native, duration_unit}
          ),

          # Track request exceptions
          counter(
            metric_prefix ++ [:request, :exception, :count, :total],
            event_name: @request_exception_event,
            description: "Total number of Finch request exceptions",
            tags: [:finch_name, :method, :scheme, :host, :port, :kind, :reason],
            tag_values: &finch_request_exception_tag_values/1
          )
        ]
      )
    end

    defp queue_metrics(metric_prefix, duration_unit) do
      duration_unit_plural = String.to_atom("#{duration_unit}s")

      Event.build(
        :finch_queue_event_metrics,
        [
          # Track queue wait time
          distribution(
            metric_prefix ++ [:queue, :duration, duration_unit_plural],
            event_name: @queue_stop_event,
            measurement: :duration,
            description: "The time spent waiting in the connection pool queue",
            tags: [:finch_name, :scheme, :host, :port, :pool],
            tag_values: &finch_queue_tag_values/1,
            reporter_options: [
              buckets: [1, 5, 10, 25, 50, 100, 250, 500, 1_000]
            ],
            unit: {:native, duration_unit}
          ),

          # Track connection idle time when checked out from pool
          distribution(
            metric_prefix ++ [:queue, :idle_time, duration_unit_plural],
            event_name: @queue_stop_event,
            measurement: :idle_time,
            description: "The time the connection spent idle before being used",
            tags: [:finch_name, :scheme, :host, :port, :pool],
            tag_values: &finch_queue_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 100, 250, 500, 1_000, 5_000, 10_000]
            ],
            unit: {:native, duration_unit}
          ),

          # Track queue exceptions
          counter(
            metric_prefix ++ [:queue, :exception, :count, :total],
            event_name: @queue_exception_event,
            description: "Total number of Finch queue exceptions",
            tags: [:finch_name, :scheme, :host, :port, :kind, :reason],
            tag_values: &finch_queue_exception_tag_values/1
          )
        ]
      )
    end

    defp connection_metrics(metric_prefix, duration_unit) do
      duration_unit_plural = String.to_atom("#{duration_unit}s")

      Event.build(
        :finch_connection_event_metrics,
        [
          # Track connection establishment time
          distribution(
            metric_prefix ++ [:connect, :duration, duration_unit_plural],
            event_name: @connect_stop_event,
            measurement: :duration,
            description: "The time spent establishing a connection",
            tags: [:finch_name, :scheme, :host, :port, :error],
            tag_values: &finch_connect_tag_values/1,
            reporter_options: [
              buckets: [10, 50, 100, 250, 500, 1_000, 2_500, 5_000]
            ],
            unit: {:native, duration_unit}
          ),

          # Track connection attempts
          counter(
            metric_prefix ++ [:connect, :count, :total],
            event_name: @connect_start_event,
            description: "Total number of connection attempts",
            tags: [:finch_name, :scheme, :host, :port],
            tag_values: &finch_connect_start_tag_values/1
          )
        ]
      )
    end

    defp send_metrics(metric_prefix, duration_unit) do
      duration_unit_plural = String.to_atom("#{duration_unit}s")

      Event.build(
        :finch_send_event_metrics,
        [
          # Track send duration
          distribution(
            metric_prefix ++ [:send, :duration, duration_unit_plural],
            event_name: @send_stop_event,
            measurement: :duration,
            description: "The time spent sending the request",
            tags: [:finch_name, :method, :scheme, :host, :port, :error],
            tag_values: &finch_send_tag_values/1,
            reporter_options: [
              buckets: [1, 5, 10, 25, 50, 100, 250, 500, 1_000]
            ],
            unit: {:native, duration_unit}
          ),

          # Track send idle time
          distribution(
            metric_prefix ++ [:send, :idle_time, duration_unit_plural],
            event_name: @send_stop_event,
            measurement: :idle_time,
            description: "The time the connection spent idle before sending",
            tags: [:finch_name, :method, :scheme, :host, :port, :error],
            tag_values: &finch_send_tag_values/1,
            reporter_options: [
              buckets: [1, 5, 10, 25, 50, 100, 250, 500]
            ],
            unit: {:native, duration_unit}
          )
        ]
      )
    end

    # Tag extraction functions
    defp finch_request_tag_values(%{name: name, request: request, result: result}) do
      %{
        finch_name: name,
        method: normalize_method(request.method),
        scheme: request.scheme,
        host: request.host,
        port: request.port,
        status: extract_status_from_result(result)
      }
    end

    defp finch_request_exception_tag_values(%{name: name, request: request, kind: kind, reason: reason}) do
      %{
        finch_name: name,
        method: normalize_method(request.method),
        scheme: request.scheme,
        host: request.host,
        port: request.port,
        kind: kind,
        reason: inspect(reason)
      }
    end

    defp finch_queue_tag_values(%{name: name, pool: pool, request: request}) do
      %{
        finch_name: name,
        scheme: request.scheme,
        host: request.host,
        port: request.port,
        pool: inspect(pool)
      }
    end

    defp finch_queue_exception_tag_values(%{name: name, request: request, kind: kind, reason: reason}) do
      %{
        finch_name: name,
        scheme: request.scheme,
        host: request.host,
        port: request.port,
        kind: kind,
        reason: inspect(reason)
      }
    end

    defp finch_connect_tag_values(%{name: name, scheme: scheme, host: host, port: port} = metadata) do
      error = Map.get(metadata, :error)
      %{
        finch_name: name,
        scheme: scheme,
        host: host,
        port: port,
        error: if(error, do: inspect(error), else: "none")
      }
    end

    defp finch_connect_start_tag_values(%{name: name, scheme: scheme, host: host, port: port}) do
      %{
        finch_name: name,
        scheme: scheme,
        host: host,
        port: port
      }
    end

    defp finch_send_tag_values(%{name: name, request: request} = metadata) do
      error = Map.get(metadata, :error)
      %{
        finch_name: name,
        method: normalize_method(request.method),
        scheme: request.scheme,
        host: request.host,
        port: request.port,
        error: if(error, do: inspect(error), else: "none")
      }
    end

    defp normalize_method(method) when is_atom(method), do: String.upcase(Atom.to_string(method))
    defp normalize_method(method) when is_binary(method), do: String.upcase(method)

    defp extract_status_from_result({:ok, %{status: status}}), do: Integer.to_string(status)
    defp extract_status_from_result({:error, _reason}), do: "error"
    defp extract_status_from_result(_), do: "unknown"
  end
else
  defmodule PromEx.Plugins.Finch do
    @moduledoc false
    use PromEx.Plugin

    @impl true
    def event_metrics(_opts), do: []
  end
end