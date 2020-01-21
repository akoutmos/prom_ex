defmodule PromEx.StandardMetrics do
  @moduledoc """
  This struct defines the fields necessary to export a group of
  standard metrics from a plugin.
  """

  alias __MODULE__

  defstruct group_name: :default, metrics: []

  def build(metrics), do: build(:default, metrics)

  def build(group_name, metrics) do
    %MetricsConfig{
      group_name: group_name,
      metrics: metrics
    }
  end
end
