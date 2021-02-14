defmodule WebApp.Recorder do
  @moduledoc """
  Records telemetry events for testing
  """

  use GenServer

  # Client
  def start_link(metrics) do
    GenServer.start_link(__MODULE__, metrics)
  end

  # Server
  def init(metrics) do
    :telemetry.attach_many(make_ref(), metrics, &__MODULE__.track/4, self())
    {:ok, %{count: 0, events: %{}}}
  end

  def handle_info({:track, metric}, state) do
    IO.inspect(map_size(state.events), label: "events")
    {:noreply, %{count: state.count + 1, events: Map.put(state.events, state.count, metric)}}
  end

  @doc false
  def track(event, measurements, metadata, pid) do
    IO.inspect({event, measurements, metadata, pid}, label: "event")
    send(
      pid,
      {:track,
       %{
         event: event,
         measurements: measurements,
         metadata: metadata
       }}
    )
  end
end
