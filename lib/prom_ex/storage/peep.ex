defmodule PromEx.Storage.Peep do
  @moduledoc """
  This store uses [Peep](https://github.com/rkallos/peep) as the storage
  mechanism for metrics.
  """

  @behaviour PromEx.Storage

  @impl true
  def scrape(name) do
    name
    |> Peep.get_all_metrics()
    |> Peep.Prometheus.export()
  end

  @impl true
  def child_spec(name, metrics) do
    opts = [
      name: name,
      metrics: metrics
    ]

    Peep.child_spec(opts)
  end
end
