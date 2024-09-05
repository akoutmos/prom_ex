defmodule PromEx.MetricTypes.Polling do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of pollable metric sources from a plugin.
  """

  require Logger

  @typedoc """
  - `group_name`: A unique identifier for the collection of metrics.
  - `measurements_mfa`: An MFA tuple that defines what function will be
    executed that will emit Telemetry events.
  - `metrics`: A list of Telemetry Metrics structs that define the metrics.
  - `poll_rate`: An integer representing the millisecond between metrics samples.
  - `opts`: A keyword list of options to configure the execution of the polling job.
    The supported options are currently:
      - `detach_on_error`: Configures whether your MFA will stop being invoked
        after it encounters an error. The default for this is `true`.
  """

  @type t :: %__MODULE__{
          group_name: atom(),
          poll_rate: pos_integer(),
          measurements_mfa: PromEx.measurements_mfa(),
          metrics: list(PromEx.telemetry_metrics()),
          opts: keyword()
        }

  defstruct group_name: :default, poll_rate: 5_000, measurements_mfa: nil, metrics: [], opts: []

  @default_opts [
    detach_on_error: true
  ]

  @doc """
  Create a struct that encompasses a group of polling type metrics. The `group_name` should be unique and should follow
  the following convention: `<APPLICATION>_<SHORT DESCRIPTION>_manual_metrics`. For example, BEAM related memory metrics
  have a `group_name` of: `:beam_memory_polling_events`
  """
  @spec build(
          group_name :: atom(),
          poll_rate :: pos_integer(),
          measurements_mfa :: PromEx.measurements_mfa(),
          metrics :: list(PromEx.telemetry_metrics()),
          opts :: keyword()
        ) ::
          __MODULE__.t()
  def build(group_name, poll_rate, measurements_mfa, metrics, opts \\ []) do
    opts = Keyword.merge(@default_opts, opts)

    if opts[:detach_on_error] do
      %__MODULE__{
        group_name: group_name,
        poll_rate: poll_rate,
        measurements_mfa: measurements_mfa,
        metrics: metrics
      }
    else
      %__MODULE__{
        group_name: group_name,
        poll_rate: poll_rate,
        measurements_mfa: {__MODULE__, :safe_polling_runner, [measurements_mfa]},
        metrics: metrics
      }
    end
  end

  @doc false
  @spec safe_polling_runner(mfa :: mfa()) :: :ok | :error
  def safe_polling_runner({module, function, args} = mfa) do
    apply(module, function, args)
    :ok
  rescue
    error ->
      Logger.warning("MFA #{inspect(mfa)} encountered an error but has not been detached: #{inspect(error)}")
      :error
  end
end
