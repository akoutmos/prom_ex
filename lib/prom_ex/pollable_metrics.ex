defmodule PromEx.PollableMetrics do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of pollable metric sources from a plugin.
  """

  @type t :: %__MODULE__{
          group_name: atom,
          metrics: list,
          measurements_mfa: tuple,
          poll_rate: integer
        }

  defstruct group_name: :default, measurements_mfa: nil, metrics: [], poll_rate: 5_000

  def build(measurements_mfa, metrics), do: build(:default, 5_000, measurements_mfa, metrics)

  def build(group_name, poll_rate, measurements_mfa, metrics) do
    %__MODULE__{
      group_name: group_name,
      metrics: metrics,
      measurements_mfa: measurements_mfa,
      poll_rate: poll_rate
    }
  end
end
