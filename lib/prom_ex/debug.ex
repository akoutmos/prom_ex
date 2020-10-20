defmodule PromEx.Debug do
  # credo:disable-for-this-file Credo.Check.Warning.IoInspect

  @moduledoc """
  This is a convenience module used for debugging and introspecting
  telemetry events. Primarily used to ease for development or
  PromEx itself.
  """

  @typep metrics_types :: PromEx.MetricTypes.Event.t() | PromEx.MetricTypes.Manaul.t() | PromEx.MetricTypes.Polling.t()

  @doc """
  Use this function to attach a debugger handler to a certain telemetry event. This
  function will also return the
  """
  @spec attach_debugger(metrics_types() | list()) :: :ok | metrics_types()
  def(attach_debugger(%_{event_name: event_name} = telemetry_metric_def)) do
    random_id =
      10
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64()
      |> binary_part(0, 10)

    config = %{
      handler_id: random_id,
      telemetry_metric: telemetry_metric_def
    }

    :telemetry.attach(
      random_id,
      event_name,
      fn event_name, event_measurement, event_metadata, config ->
        IO.inspect(event_name, label: "---- EVENT NAME ----")
        IO.inspect(event_measurement, label: "---- EVENT MEASUREMENT ----")
        IO.inspect(event_metadata, label: "---- EVENT METADATA ----")
        IO.inspect(config, label: "---- CONFIG ----")
      end,
      config
    )

    telemetry_metric_def
  end

  def attach_debugger(event) when is_list(event) do
    random_id =
      10
      |> :crypto.strong_rand_bytes()
      |> Base.url_encode64()
      |> binary_part(0, 10)

    config = %{
      handler_id: random_id,
      event: event
    }

    :telemetry.attach(
      random_id,
      event,
      fn event_name, event_measurement, event_metadata, config ->
        IO.inspect(event_name, label: "---- EVENT NAME ----")
        IO.inspect(event_measurement, label: "---- EVENT MEASUREMENT ----")
        IO.inspect(event_metadata, label: "---- EVENT METADATA ----")
        IO.inspect(config, label: "---- CONFIG ----")
      end,
      config
    )

    :ok
  end
end
