defmodule PromEx.ManualMetricsManager do
  @moduledoc """
  This GenServer is responsible to keeping track of all the manual
  metrics from your configured plugins. It will fetch metrics initially
  when starting (either immediately or after a configured delay). At that
  point if you would like to refresh your metrics data points call the
  `refresh_metrics/1` function.
  """

  use GenServer

  require Logger

  @doc """
  Used to start the `PromEx.ManualMetricsManager` process
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @doc """
  This function calls into the GenServer and refreshes all of the configured
  manual metrics data points.
  """
  @spec refresh_metrics(prom_ex_module :: module()) :: :ok
  def refresh_metrics(prom_ex_module) do
    prom_ex_module.__manual_metrics_name__()
    |> GenServer.cast(:refresh_metrics)
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
    internal_refresh_metrics(state)

    {:noreply, state}
  end

  @impl true
  def handle_info(:refresh_metrics, state) do
    internal_refresh_metrics(state)

    {:noreply, state}
  end

  @impl true
  def handle_cast(:refresh_metrics, state) do
    internal_refresh_metrics(state)

    {:noreply, state}
  end

  defp internal_refresh_metrics(state) do
    state.metrics
    |> Enum.each(fn {module, function, args} ->
      apply(module, function, args)
    end)
  end
end
