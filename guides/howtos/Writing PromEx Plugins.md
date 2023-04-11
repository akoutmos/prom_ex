# Writing PromEx Plugins

This guide will walk you through writing a PromEx plugin. Whether this plugin is for a dependent library or for your
internal application metrics, the same patterns apply.

## Getting started

In order for PromEx to be able to load the appropriate metrics from your plugins, your modules need to leverage the
`PromEx` behaviour. This behaviour defines 3 optional callbacks. Those callbacks are:

- `event_metrics/1`
- `polling_metrics/1`
- `manual_metrics/1`

Each of these callbacks is supposed to return a list of metrics of that type. For example, `polling_metrics/1` needs to
return a list of `PromEx.MetricTypes.Polling` structs (a single struct is also an acceptable return). By doing this, your
plugin can load your metrics and deal with the nuances of each metric type properly. Each of the `MetricTypes` structs
all have a field called `:metrics`. This field contains a list of all the `Telemetry.Metrics` definitions that were
provided to the struct `build` function.

## Adding Event Metrics

To have your custom plugin expose event based metrics, implement a `event_metrics/1` function and build out a collection
of `Telemetry.Metrics` structs (`distribution`, `counter`, `last_value`, and `sum`). Be sure to look at plugins like
`PromEx.Plugins.Phoenix` for more in depth examples.

```elixir
defmodule MyApp.PromEx.Plugins.MyPhoenix do
  use PromEx.Plugin

  @impl true
  def event_metrics(opts) do
    http_metrics_tags = gen_http_metrics_tags(opts)
    phoenix_router = get_phoenix_router(opts)
    phoenix_stop_event = [:phoenix, :endpoint, :stop]

    Event.build(
      :phoenix_http_event_metrics,
      [
        # Capture request duration information
        distribution(
          [:phoenix, :http, :request, :duration, :milliseconds],
          event_name: phoenix_stop_event,
          measurement: :duration,
          description: "The time it takes for the application to respond to HTTP requests.",
          reporter_options: [
            buckets: exponential!(1, 2, 12)
          ],
          tag_values: get_conn_tags(phoenix_router),
          tags: http_metrics_tags,
          unit: {:native, :millisecond}
        )

        # Additional event based metrics ...
      ]
    )
  end
end
```

## Adding Polling Metrics

Polling metrics are similar to event metrics in that they require similar fields (`group_name` and `metrics` to be
specific). In addition, the `PromEx.MetricTypes.Polling.build/4` function requires an `measurements_mfa` argument which
specifies what function will be executed on the polling interval. This function should run `:telemetry.execute/3`
somewhere in its function body. Once that event is executed, the corresponding event in the struct will be triggered and
you will capture the desired data point. The following example from `PromEx.Plugins.Beam` should highlight this concept:

```elixir
defmodule PromEx.Plugins.Beam do
  use PromEx.Plugin

  @memory_event [:prom_ex, :plugin, :beam, :memory]

  @impl true
  def polling_metrics(opts) do
    poll_rate = Keyword.get(opts, :poll_rate, 5_000)

    [
      memory_metrics(poll_rate)
    ]
  end

  defp memory_metrics(poll_rate) do
    Polling.build(
      :beam_memory_polling_events,
      poll_rate,
      {__MODULE__, :execute_memory_metrics, []},
      [
        # Capture the total memory allocated to the entire Erlang VM (or BEAM for short)
        last_value(
          [:beam, :memory, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated.",
          measurement: :total,
          unit: {:byte, :kilobyte}
        )

        # More memory metrics here
      ]
    )
  end

  @doc false
  def execute_memory_metrics do
    memory_measurements =
      :erlang.memory()
      |> Map.new()

    :telemetry.execute(@memory_event, memory_measurements, %{})
  end
end
```

Depending on what `:poll_rate` value you pass to the initialization tuple for `PromEx.Plugins.Beam`, the
`execute_memory_metrics/0` function will be execute on that specified interval.

## Adding Manual Metrics

Manual metrics behave more or less the same as polling metrics except they do not require a poll rate value. Instead the
provided `measurements_mfa` is called once on application start, and the metrics are only then updated if you make a
call to `PromEx.ManualMetricsManager.refresh_metrics/1`. An example of this can be seen from the
`PromEx.Plugins.Application` plugin:

```elixir
defmodule PromEx.Plugins.Application do
  use PromEx.Plugin

  @impl true
  def manual_metrics(opts) do
    otp_app = Keyword.fetch!(opts, :otp_app)
    apps = Keyword.get(opts, :deps, :all)

    Manual.build(
      :application_versions_manual_metrics,
      {__MODULE__, :apps_running, [otp_app, apps]},
      [
        # Capture information regarding the primary application (i.e the user's application)
        last_value(
          [otp_app | [:application, :primary, :info]],
          event_name: [otp_app | [:application, :primary, :info]],
          description: "Information regarding the primary application.",
          measurement: :status,
          tags: [:name, :version, :modules]
        )

        # Additional metrics here
      ]
    )
  end

  @doc false
  def apps_running(otp_app, apps) do
    ...

    # Emit primary app details
    :telemetry.execute(
      [otp_app | [:application, :primary, :info]],
      %{
        status: if(Map.has_key?(started_apps, otp_app), do: 1, else: 0)
      },
      %{
        name: otp_app,
        version:
          Map.get_lazy(started_apps, otp_app, fn ->
            Map.get(loaded_only_apps, otp_app, "undefined")
          end),
        modules: length(Application.spec(otp_app)[:modules])
      }
    )
  end
end
```

So in this example, `apps_running/2` is the function that is denoted by the MFA and will be called once automatically on
application start, but then at that point it is up to the user to refresh the data point.
