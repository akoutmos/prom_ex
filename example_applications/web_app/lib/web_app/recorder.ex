defmodule WebApp.Recorder do
  @moduledoc """
  Records telemetry events for testing
  """

  use GenServer

  # Client
  @doc false
  def start_link(opts) do
    {metrics, opts} = Keyword.pop!(opts, :metrics)
    GenServer.start_link(__MODULE__, metrics, opts)
  end

  @doc false
  def get_events(server) do
    GenServer.call(server, :events)
  end

  # Server
  @impl GenServer
  def init(metrics) do
    handler_id = make_ref()
    :telemetry.attach_many(handler_id, metrics, &__MODULE__.track/4, self())
    {:ok, %{count: 0, events: [], handler_id: handler_id}}
  end

  @impl GenServer
  def handle_call(:events, _from, state) do
    {:reply, Enum.reverse(state.events), state}
  end

  @impl GenServer
  def handle_cast({:track, _}, %{handler_id: nil} = state) do
    {:noreply, state}
  end

  def handle_cast({:track, _}, %{count: 100} = state) do
    :telemetry.detach(state.handler_id)
    {:noreply, %{state | handler_id: nil}}
  end

  def handle_cast({:track, metric}, state) do
    {:noreply, %{state | count: state.count + 1, events: [metric | state.events]}}
  end

  @doc false
  def track(event, measurements, metadata, pid) do
    metric = %{
      event: event,
      measurements: measurements,
      metadata: metadata
    }

    GenServer.cast(pid, {:track, metric})
  end
end
