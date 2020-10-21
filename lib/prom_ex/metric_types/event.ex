defmodule PromEx.MetricTypes.Event do
  @moduledoc """
  This struct defines the fields necessary to export a group of
  standard metrics from a plugin.
  """

  @typedoc """
  - `group_name`: A unique identifier for the collection of metrics.
  - `metrics`: A list of Telemetry Metrics structs that define the metrics.
  """

  @type t :: %__MODULE__{
          group_name: atom(),
          metrics: list(PromEx.telemetry_metrics())
        }

  defstruct group_name: :default, metrics: []

  @doc """
  Create a struct that encompasses a group of event based metrics. The `group_name` should be unique and should follow
  the following convention: `<APPLICATION>_<SHORT DESCRIPTION>_event_metrics`. For example, Phoenix HTTP related metrics
  have a `group_name` of: `:phoenix_http_event_metrics`
  """
  @spec build(group_name :: atom(), metrics :: list(PromEx.telemetry_metrics())) :: __MODULE__.t()
  def build(group_name, metrics) do
    %__MODULE__{
      group_name: group_name,
      metrics: metrics
    }
  end
end
