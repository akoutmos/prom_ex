# credo:disable-for-this-file Credo.Check.Warning.IoInspect
defmodule PromEx.Debug do
  @moduledoc """
  This is a convenience module used for debugging and introspecting
  telemetry events. Primarily used to ease the development of
  PromEx itself.
  """

  @doc """
  Use this function to attach a debugger handler to a certain telemetry event.
  """
  @spec attach_debugger(PromEx.telemetry_metrics() | list()) :: :ok | PromEx.telemetry_metrics()
  def attach_debugger(%_{event_name: event_name} = telemetry_metric_def) do
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
      &__MODULE__.handle_event/4,
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
      &__MODULE__.handle_event/4,
      config
    )

    :ok
  end

  @doc false
  @spec handle_event([atom], map, map, any) :: any
  def handle_event(event_name, event_measurement, event_metadata, config) do
    IO.inspect(event_name, label: "---- EVENT NAME ----", limit: :infinity, structs: false)
    IO.inspect(event_measurement, label: "---- EVENT MEASUREMENT ----", limit: :infinity, structs: false)
    IO.inspect(event_metadata, label: "---- EVENT METADATA ----", limit: :infinity, structs: false)
    IO.inspect(config, label: "---- CONFIG ----", limit: :infinity, structs: false)
  end
end
