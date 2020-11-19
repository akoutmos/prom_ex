defmodule PromEx.MetricTypes.Manual do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of manually collected metric sources from a plugin.
  """

  @typedoc """
  - `group_name`: A unique identifier for the collection of metrics.
  - `measurements_mfa`: An MFA tuple that defines what function will be
    executed that will emit Telemetry events.
  - `metrics`: A list of Telemetry Metrics structs that define the metrics.
  """

  @type t :: %__MODULE__{
          group_name: atom(),
          measurements_mfa: PromEx.measurements_mfa(),
          metrics: list(PromEx.telemetry_metrics())
        }

  defstruct group_name: :default, measurements_mfa: nil, metrics: []

  @doc """
  Create a struct that encompasses a group of manually triggered metrics. The `group_name` should be unique and should follow
  the following convention: `<APPLICATION>_<SHORT DESCRIPTION>_manual_metrics`. For example, Application related info metrics
  have a `group_name` of: `:application_versions_manual_metrics`
  """
  @spec build(
          group_name :: atom(),
          measurements_mfa :: PromEx.measurements_mfa(),
          metrics :: list(PromEx.telemetry_metrics())
        ) ::
          __MODULE__.t()
  def build(group_name, measurements_mfa, metrics) do
    %__MODULE__{
      group_name: group_name,
      measurements_mfa: measurements_mfa,
      metrics: metrics
    }
  end
end
