defmodule PromEx.Storage.Peep do
  @moduledoc """
  This store uses [Peep](https://github.com/rkallos/peep) as the storage
  mechanism for metrics.
  """

  @behaviour PromEx.Storage

  @impl true
  def scrape(name) do
    Peep.get_all_metrics(name)
    |> Peep.Prometheus.export()
    |> IO.iodata_to_binary()
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
