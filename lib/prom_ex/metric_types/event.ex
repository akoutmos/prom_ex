defmodule PromEx.MetricTypes.Event do
  @moduledoc """
  This struct defines the fields necessary to export a group of
  standard metrics from a plugin.
  """

  @typedoc """
  - `group_name`: A unique identifier for the collection of metrics.
  - `metrics`: A list of Telemetry Metrics structs that define the metrics.
  """

  alias Telemetry.Metrics.Distribution

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
      metrics: build_buckets(group_name, metrics)
    }
  end

  defp build_buckets(name, metrics) do
    if PromEx.storage_adapter() == PromEx.Storage.Peep do
      build_buckets_modules(name, metrics)
    else
      metrics
    end
  end

  defp build_buckets_modules(name, metrics) do
    metrics
    |> Enum.with_index()
    |> Enum.map(&build_bucket(name, &1))
  end

  defp build_bucket(name, {%Distribution{} = dist, idx}) do
    reporter_options =
      Keyword.put_new_lazy(dist.reporter_options, :peep_bucket_calculator, fn ->
        buckets = Keyword.fetch!(dist.reporter_options, :buckets)

        {:module, name, _, _} =
          Module.create(
            Module.concat(name, "Bucket_#{idx}"),
            quote do
              use Peep.Buckets.Custom, buckets: unquote(buckets)
            end,
            __ENV__
          )

        name
      end)

    %Distribution{dist | reporter_options: reporter_options}
  end

  defp build_bucket(_name, {other, _}), do: other
end
