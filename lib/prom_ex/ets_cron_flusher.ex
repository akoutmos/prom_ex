defmodule PromEx.ETSCronFlusher do
  @moduledoc """
  This module is used to regularly flush ETS of any buffered distribution
  type metrics (see https://github.com/beam-telemetry/telemetry_metrics_prometheus_core/blob/main/lib/core.ex#L25-L28)
  for more information. At the moment the flush interval is not configurable
  but that could change in the future.
  """

  use GenServer

  @doc """
  Used to start the `PromEx.ETSCronFlusher` process.
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop(opts, :name)

    state =
      remaining_opts
      |> Map.new()
      |> Map.put(:timer_ref, nil)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @doc """
  This function will cancel the existing cron timer and schedule a new
  new. The reason for this being that if metrics scrapes occur regularly,
  there is no need to flush via the cron job. Cron ETS flushes should
  only occur if the metrics endpoint for whatever reason fails to be
  scraped so that ETS is not leaking memory.
  """
  @spec defer_ets_flush(instance :: module()) :: :ok
  def defer_ets_flush(instance) do
    GenServer.cast(instance, :defer_ets_flush)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :start_cron_flusher}}
  end

  @impl true
  def handle_continue(:start_cron_flusher, state) do
    timer_ref = schedule_flush(state)
    {:noreply, %{state | timer_ref: timer_ref}}
  end

  @impl true
  def handle_info(:flush_ets, state) do
    PromEx.get_metrics(state.prom_ex_module)

    timer_ref = schedule_flush(state)
    {:noreply, %{state | timer_ref: timer_ref}}
  end

  @impl true
  def handle_cast(:defer_ets_flush, state) do
    # Cancel the existing timer
    Process.cancel_timer(state.timer_ref)

    timer_ref = schedule_flush(state)
    {:noreply, %{state | timer_ref: timer_ref}}
  end

  defp schedule_flush(%{ets_flush_interval: ets_flush_interval}) do
    Process.send_after(self(), :flush_ets, ets_flush_interval)
  end
end
