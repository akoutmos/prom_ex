defmodule PromEx.ManualMetricsManager do
  @moduledoc """
  This GenServer is responsible to keeping track of all the manual
  metrics from your configured plugins. It will fetch metrics initially
  when starting (either immediately or after a configured delay). At that
  point if you would like to refresh your metrics data points call the
  `refresh_metrics/0` function.
  """

  use GenServer

  require Logger

  @doc """
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    state = Map.new(opts)

    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @doc """
  This function calls into the GenServer and refreshes all of the configured
  manual metrics data points.
  """
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
