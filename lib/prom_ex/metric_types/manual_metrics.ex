defmodule PromEx.MetricTypes.Manual do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of pollable metric sources from a plugin.
  """

  @type t :: %__MODULE__{
          group_name: atom,
          metrics: list
        }

  defstruct group_name: :default, measurements_mfa: nil, metrics: []

  def build(measurements_mfa, metrics), do: build(:default, measurements_mfa, metrics)

  def build(group_name, measurements_mfa, metrics) do
    %__MODULE__{
      group_name: group_name,
      measurements_mfa: measurements_mfa,
      metrics: metrics
    }
  end
end
