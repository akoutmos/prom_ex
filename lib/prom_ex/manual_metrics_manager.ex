defmodule PromEx.ManualMetricsManager do
  @moduledoc """
  """

  use GenServer

  require Logger

  def start_link(opts) do
    state = Map.new(opts)

    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def refresh_metrics do
    GenServer.cast(__MODULE__, :refresh_metrics)
  end

  @impl true
  def init(%{metrics: []}) do
    Logger.debug("No PromEx ManualMetrics have been configured. Stopping PromEx.ManualMetricsManager")

    :ignore
  end

  def init(%{delay_manual_start: :no_delay} = state) do
    {:ok, state, {:continue, :refresh_metrics}}
  end

  def init(%{delay_manual_start: delay_duration} = state) when delay_duration > 0 do
    Process.send_after(self(), :refresh_metrics, delay_duration)

    {:ok, state}
  end

  @impl true
  def handle_continue(:refresh_metrics, state) do
    refresh_metrics(state)

    {:noreply, state}
  end

  @impl true
  def handle_info(:refresh_metrics, state) do
    refresh_metrics(state)

    {:noreply, state}
  end

  @impl true
  def handle_cast(:refresh_metrics, state) do
    refresh_metrics(state)

    {:noreply, state}
  end

  defp refresh_metrics(state) do
    state.metrics
    |> Enum.each(fn {module, function, args} ->
      apply(module, function, args)
    end)
  end
end
