defmodule PromEx.MetricTypes.Polling do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of pollable metric sources from a plugin.
  """

  @typedoc """
  - `group_name`: A unique identifier for the collection of metrics.
  - `measurements_mfa`: An MFA tuple that defines what function will be
    executed that will emit Telemetry events.
  - `metrics`: A list of Telemetry Metrics structs that define the metrics.
  - `poll_rate`: An integer representing the millisecond between metrics samples.
  """

  @type t :: %__MODULE__{
          group_name: atom(),
          poll_rate: pos_integer(),
          measurements_mfa: PromEx.measurements_mfa(),
          metrics: list(PromEx.telemetry_metrics())
        }

  defstruct group_name: :default, poll_rate: 5_000, measurements_mfa: nil, metrics: []

  @doc """
  Create a struct that encompasses a group of polling type metrics. The `group_name` should be unique and should follow
  the following convention: `<APPLICATION>_<SHORT DESCRIPTION>_manual_metrics`. For example, BEAM related memory metrics
  have a `group_name` of: `:beam_memory_polling_events`
  """
  @spec build(
          group_name :: atom(),
          poll_rate :: pos_integer(),
          measurements_mfa :: PromEx.measurements_mfa(),
          metrics :: list(PromEx.telemetry_metrics())
        ) ::
          __MODULE__.t()
  def build(group_name, poll_rate, measurements_mfa, metrics) do
    %__MODULE__{
      group_name: group_name,
      poll_rate: poll_rate,
      measurements_mfa: measurements_mfa,
      metrics: metrics
    }
  end
end
