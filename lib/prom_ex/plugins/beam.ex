defmodule PromEx.Plugins.Beam do
  @moduledoc """
  Telemetry metrics for the BEAM.

  This plugin captures metrics regarding the Erlang Virtual Machine (i.e the BEAM). Specifically, it captures metrics
  regarding the CPU topology, system limits, VM feature support, scheduler information, memory utilization, distribution
  traffic, and other internal metrics.

  This plugin supports the following options:
  - `poll_rate`: This is option is OPTIONAL and is the rate at which poll metrics are refreshed (default is 5 seconds).

  This plugin exposes the following metric groups:
  - `:beam_memory_polling_metrics`
  - `:beam_cpu_topology_manual_metrics`
  - `:beam_system_limits_manual_metrics`
  - `:beam_system_info_manual_metrics`
  - `:beam_scheduler_manual_metrics`

  To use plugin in your application, add the following to your application supervision tree:
  ```
  def start(_type, _args) do
    children = [
      ...
      {
        PromEx,
        plugins: [
          PromEx.Plugins.Beam
          ...
        ],
        delay_manual_start: :no_delay
      }
    ]

    opts = [strategy: :one_for_one, name: WebApp.Supervisor]
    Supervisor.start_link(children, opts)
  end
  ```

  This plugin exposes manual metrics so be sure to configure the PromEx `:delay_manual_start` as required.
  """

  use PromEx

  require Logger

  @memory_event [:prom_ex, :plugin, :beam, :memory]

  @impl true
  def polling_metrics(opts) do
    poll_rate = Keyword.get(opts, :poll_rate, 5_000)

    # TODO: Investigate Microstate accounting metrics
    # http://erlang.org/doc/man/erlang.html#statistics_microstate_accounting

    [
      memory_metrics(poll_rate),
      mnesia_metrics(poll_rate),
      distribution_metrics(poll_rate),
      beam_internal_metrics(poll_rate)
    ]
  end

  @impl true
  def manual_metrics(_opts) do
    [
      beam_cpu_topology_info(),
      beam_system_limits_info(),
      beam_system_info(),
      beam_scheduler_info()
    ]
  end

  defp distribution_metrics(poll_rate) do
    Polling.build(
      :beam_distribution_polling_metrics,
      poll_rate,
      {__MODULE__, :execute_distribution_metrics, []},
      []
    )
  end

  defp mnesia_metrics(poll_rate) do
    Polling.build(
      :beam_mnesia_polling_metrics,
      poll_rate,
      {__MODULE__, :execute_mnesia_metrics, []},
      []
    )
  end

  defp beam_internal_metrics(poll_rate) do
    # TODO: Additional metrics
    # https://github.com/deadtrickster/prometheus.erl/blob/master/src/collectors/vm/prometheus_vm_statistics_collector.erl#L157
    Polling.build(
      :beam_internal_polling_metrics,
      poll_rate,
      {__MODULE__, :execute_internal_metrics, []},
      [
        last_value(
          [:beam, :stats, :port, :count],
          event_name: [:prom_ex, :plugin, :beam, :port, :count],
          description: "A count of how many ports are currently active.",
          measurement: :count
        ),
        last_value(
          [:beam, :stats, :process, :count],
          event_name: [:prom_ex, :plugin, :beam, :process, :count],
          description: "A count of how many processes are currently running.",
          measurement: :count
        ),
        last_value(
          [:beam, :stats, :atom, :count],
          event_name: [:prom_ex, :plugin, :beam, :atom, :count],
          description: "A count of how many atoms are currently allocated.",
          measurement: :count
        ),
        last_value(
          [:beam, :stats, :ets, :count],
          event_name: [:prom_ex, :plugin, :beam, :ets, :count],
          description: "A count of how many ETS tables currently exist.",
          measurement: :count
        )
      ]
    )
  end

  defp beam_system_info do
    Manual.build(
      :beam_system_info_manual_metrics,
      {__MODULE__, :execute_system_info, []},
      [
        last_value(
          [:beam, :system, :version, :info],
          event_name: [:prom_ex, :plugin, :beam, :version],
          description: "The OTP release major version.",
          measurement: :version
        ),
        last_value(
          [:beam, :system, :smp_support, :info],
          event_name: [:prom_ex, :plugin, :beam, :smp_support],
          description: "Whether the BEAM instance has been compiled with SMP support.",
          measurement: :enabled
        ),
        last_value(
          [:beam, :system, :thread_support, :info],
          event_name: [:prom_ex, :plugin, :beam, :thread_support],
          description: "Whether the BEAM instance has been compiled with threading support.",
          measurement: :enabled
        ),
        last_value(
          [:beam, :system, :time_correction_support, :info],
          event_name: [:prom_ex, :plugin, :beam, :time_correction_support],
          description: "Whether the BEAM instance has time correction support.",
          measurement: :enabled
        ),
        last_value(
          [:beam, :system, :word_size_bytes, :info],
          event_name: [:prom_ex, :plugin, :beam, :word_size_bytes],
          description: "The size of Erlang term words in bytes.",
          measurement: :size
        )
      ]
    )
  end

  defp beam_scheduler_info do
    Manual.build(
      :beam_scheduler_manual_metrics,
      {__MODULE__, :execute_scheduler_info, []},
      [
        last_value(
          [:beam, :system, :dirty_cpu_schedulers, :info],
          event_name: [:prom_ex, :plugin, :beam, :dirty_cpu_schedulers],
          description: "The total number of dirty CPU scheduler threads used by the BEAM.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :dirty_cpu_schedulers_online, :info],
          event_name: [:prom_ex, :plugin, :beam, :dirty_cpu_schedulers_online],
          description: "The total number of dirty CPU schedulers that are online.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :dirty_io_schedulers, :info],
          event_name: [:prom_ex, :plugin, :beam, :dirty_io_schedulers],
          description: "The total number of dirty I/O schedulers used to execute I/O bound native functions.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :schedulers, :info],
          event_name: [:prom_ex, :plugin, :beam, :schedulers],
          description: "The number of scheduler threads in use by the BEAM.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :schedulers_online, :info],
          event_name: [:prom_ex, :plugin, :beam, :schedulers_online],
          description: "The number of scheduler threads that are online.",
          measurement: :quantity
        )
      ]
    )
  end

  defp beam_cpu_topology_info do
    Manual.build(
      :beam_cpu_topology_manual_metrics,
      {__MODULE__, :execute_cpu_topology_info, []},
      [
        last_value(
          [:beam, :system, :logical_processors, :info],
          event_name: [:prom_ex, :plugin, :beam, :logical_processors],
          description: "The total number of logical processors on the host machine.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :logical_processors_available, :info],
          event_name: [:prom_ex, :plugin, :beam, :logical_processors_available],
          description: "The total number of logical processors available to the BEAM.",
          measurement: :quantity
        ),
        last_value(
          [:beam, :system, :logical_processors_online, :info],
          event_name: [:prom_ex, :plugin, :beam, :logical_processors_online],
          description: "The total number of logical processors online on the host machine.",
          measurement: :quantity
        )
      ]
    )
  end

  defp beam_system_limits_info do
    Manual.build(
      :beam_system_limits_manual_metrics,
      {__MODULE__, :execute_system_limits_info, []},
      [
        last_value(
          [:beam, :system, :ets_limit, :info],
          event_name: [:prom_ex, :plugin, :beam, :ets_limit],
          description:
            "The maximum number of ETS tables allowed (this is partially obsolete given that the number of ETS tables is limited by available memory).",
          measurement: :limit
        ),
        last_value(
          [:beam, :system, :port_limit, :info],
          event_name: [:prom_ex, :plugin, :beam, :port_limit],
          description: "The maximum number of ports that can simultaneously exist on the BEAM instance.",
          measurement: :limit
        ),
        last_value(
          [:beam, :system, :process_limit, :info],
          event_name: [:prom_ex, :plugin, :beam, :process_limit],
          description: "The maximum number of processes that can simultaneously exist on the BEAM instance.",
          measurement: :limit
        ),
        last_value(
          [:beam, :system, :thread_pool_size, :info],
          event_name: [:prom_ex, :plugin, :beam, :thread_pool_size],
          description: "The number of async threads in the async threads pool used for async driver calls.",
          measurement: :size
        ),
        last_value(
          [:beam, :system, :atom_limit, :info],
          event_name: [:prom_ex, :plugin, :beam, :atom_limit],
          description: "The maximum number of atoms allowed.",
          measurement: :limit
        )
      ]
    )
  end

  defp memory_metrics(poll_rate) do
    Polling.build(
      :beam_memory_polling_metrics,
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

  @doc false
  def execute_distribution_metrics do
  end

  @doc false
  def execute_internal_metrics do
    :telemetry.execute([:prom_ex, :plugin, :beam, :port, :count], %{count: :erlang.system_info(:port_count)})
    :telemetry.execute([:prom_ex, :plugin, :beam, :process, :count], %{count: :erlang.system_info(:process_count)})
    :telemetry.execute([:prom_ex, :plugin, :beam, :atom, :count], %{count: :erlang.system_info(:atom_count)})
    :telemetry.execute([:prom_ex, :plugin, :beam, :ets, :count], %{count: :erlang.system_info(:ets_count)})
  end

  @doc false
  def execute_mnesia_metrics do
    # https://github.com/deadtrickster/prometheus.erl/blob/master/src/collectors/mnesia/prometheus_mnesia_collector.erl
  end

  @doc false
  def execute_system_limits_info do
    :telemetry.execute([:prom_ex, :plugin, :beam, :ets_limit], %{limit: :erlang.system_info(:ets_limit)}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :port_limit], %{limit: :erlang.system_info(:port_limit)}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :process_limit], %{limit: :erlang.system_info(:process_limit)}, %{})

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :thread_pool_size],
      %{size: :erlang.system_info(:thread_pool_size)},
      %{}
    )

    :telemetry.execute([:prom_ex, :plugin, :beam, :atom_limit], %{limit: :erlang.system_info(:atom_limit)}, %{})
  end

  @doc false
  def execute_system_info do
    smp_enabled = if(:erlang.system_info(:smp_support), do: 1, else: 0)
    thread_support_enabled = if(:erlang.system_info(:threads), do: 1, else: 0)
    time_correction_enabled = if(:erlang.system_info(:time_correction), do: 1, else: 0)
    word_size = :erlang.system_info(:wordsize)
    version = :otp_release |> :erlang.system_info() |> :erlang.list_to_binary() |> String.to_integer()

    :telemetry.execute([:prom_ex, :plugin, :beam, :smp_support], %{enabled: smp_enabled}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :thread_support], %{enabled: thread_support_enabled}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :time_correction_support], %{enabled: time_correction_enabled}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :word_size_bytes], %{size: word_size}, %{})
    :telemetry.execute([:prom_ex, :plugin, :beam, :version], %{version: version}, %{})
  end

  @doc false
  def execute_cpu_topology_info do
    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :logical_processors],
      %{quantity: :erlang.system_info(:logical_processors)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :logical_processors_available],
      %{quantity: :erlang.system_info(:logical_processors_available)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :logical_processors_online],
      %{quantity: :erlang.system_info(:logical_processors_online)},
      %{}
    )
  end

  @doc false
  def execute_scheduler_info do
    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :dirty_cpu_schedulers],
      %{quantity: :erlang.system_info(:dirty_cpu_schedulers)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :dirty_cpu_schedulers_online],
      %{quantity: :erlang.system_info(:dirty_cpu_schedulers_online)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :dirty_io_schedulers],
      %{quantity: :erlang.system_info(:dirty_io_schedulers)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :schedulers],
      %{quantity: :erlang.system_info(:schedulers)},
      %{}
    )

    :telemetry.execute(
      [:prom_ex, :plugin, :beam, :schedulers_online],
      %{quantity: :erlang.system_info(:schedulers_online)},
      %{}
    )
  end
end
