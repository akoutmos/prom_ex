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
  @callback child_spec(atom(), list(Telemetry.Metrics.t())) :: Supervisor.child_spec()

  @doc """
  Extract the metrics out of the configured store.
  """
  @spec scrape(mod :: module(), name :: module()) :: iodata() | :prom_ex_down
  def scrape(mod, name) do
    mod.scrape(name)
  end

  @doc """
  Generate the process child spec for the store.
  """
  @spec child_spec(mod :: module(), name :: module(), metrics :: list(Telemetry.Metrics.t())) :: Supervisor.child_spec()
  def child_spec(mod, name, metrics) do
    mod.child_spec(name, metrics)
  end
end
