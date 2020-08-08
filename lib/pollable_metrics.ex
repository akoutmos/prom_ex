defmodule PromEx.PollableMetrics do
  @moduledoc """
  This struct defines the fields necessary to export a group
  of pollable metric sources from a plugin.
  """

  alias __MODULE__

  @type t :: %PollableMetrics{group_name: atom, measurements: list, period: integer}

  defstruct group_name: :default, measurements: [], period: 5_000

  def build(measurements), do: build(:default, 5_000, measurements)

  def build(group_name, period, measurements) do
    %PollerConfig{
      group_name: group_name,
      measurements: measurements,
      period: period
    }
  end
end
