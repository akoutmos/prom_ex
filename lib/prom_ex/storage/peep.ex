if Code.ensure_loaded?(Peep) do
  defmodule PromEx.Storage.Peep do
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
end
