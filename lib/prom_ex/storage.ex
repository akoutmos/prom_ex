defmodule PromEx.Storage do
  @moduledoc """
  Storage definition behaviour.
  """

  @doc """
  Gather metrics for given collector with given `name`.
  """
  @callback scrape(name :: atom()) :: iodata() | :prom_ex_down

  @doc """
  Define child specs for gatherer process.
  """
  @callback child_spec(atom(), Telemetry.Metrics.metrics()) :: Supervisor.child_spec()

  def scrape(mod, name), do: mod.scrape(name)

  def child_spec(mod, name, metrics),
    do: mod.child_spec(name, metrics)
end
