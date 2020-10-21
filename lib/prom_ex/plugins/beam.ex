defmodule PromEx.Plugins.Beam do
  @moduledoc """
  Telemetry metrics for the BEAM.

  #TODO: More indepth docs coming
  """

  use PromEx

  require Logger

  @memory_event [:prom_ex, :plugin, :beam, :memory]

  @impl true
  def polling_metrics(opts) do
    poll_rate = Keyword.get(opts, :poll_rate, 5_000)

    [
      memory_metrics(poll_rate)
      # TODO: Additional metrics here
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
        ),

        # Capture the total memory allocated to atoms
        last_value(
          [:beam, :memory, :atom, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated for atoms.",
          measurement: :atom,
          unit: {:byte, :kilobyte}
        ),

        # Capture the total memory allocated to binaries
        last_value(
          [:beam, :memory, :binary, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated for binaries.",
          measurement: :binary,
          unit: {:byte, :kilobyte}
        ),

        # Capture the total memory allocated to Erlang code
        last_value(
          [:beam, :memory, :code, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated for Erlang code.",
          measurement: :code,
          unit: {:byte, :kilobyte}
        ),

        # Capture the total memory allocated to ETS tables
        last_value(
          [:beam, :memory, :ets, :total, :kilobytes],
          event_name: @memory_event,
          description: "The total amount of memory currently allocated for ETS tables.",
          measurement: :ets,
          unit: {:byte, :kilobyte}
        )
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
