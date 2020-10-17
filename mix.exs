defmodule PromEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :prom_ex,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Required dependencies
      {:telemetry, "~> 0.4.2"},
      {:telemetry_poller, "~> 0.5.1"},
      {:telemetry_metrics, github: "beam-telemetry/telemetry_metrics", branch: :master, override: true},
      {:telemetry_metrics_prometheus_core, github: "akoutmos/telemetry_metrics_prometheus_core", branch: :experimental},

      # Library development related dependencies
      {:ex_doc, "~> 0.22"},

      # Optional dependencies depending on what telemetry events the user is acting upon
      {:phoenix, "~> 1.5", optional: true},
      {:plug, "~> 1.10", optional: true}
    ]
  end

  defp docs do
    [
      main: "readme",
      logo: "guides/images/logo.svg",
      extras: ["README.md"]
    ]
  end
end
