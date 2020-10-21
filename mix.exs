defmodule PromEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :prom_ex,
      version: "0.1.0",
      elixir: "~> 1.9",
      name: "PromEx",
      source_url: "https://github.com/akoutmos/prom_ex",
      homepage_url: "https://hex.pm/packages/prom_ex",
      description: "A Plug-in style Prometheus metrics collection library built on top of Telemetry",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test
      ],
      dialyzer: [
        plt_add_apps: [:plug, :phoenix, :telemetry_metrics]
      ],
      deps: deps(),
      docs: docs(),
      aliases: aliases()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/sample_plugins"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Required dependencies
      {:telemetry, "~> 0.4.2"},
      {:telemetry_poller, "~> 0.5.1"},
      {:telemetry_metrics, github: "beam-telemetry/telemetry_metrics", branch: :master, override: true},
      {:telemetry_metrics_prometheus_core, github: "akoutmos/telemetry_metrics_prometheus_core", branch: :experimental},

      # Optional dependencies depending on what telemetry events the user is acting upon
      {:phoenix, "~> 1.5", optional: true},
      {:plug, "~> 1.10", optional: true},

      # Library development related dependencies
      {:ex_doc, "~> 0.22", only: :dev},
      {:excoveralls, "~> 0.13.3", only: :test, runtime: false},
      {:doctor, "~> 0.15.0", only: :dev},
      {:credo, "~> 1.5.0-rc.4", only: :dev},
      {:dialyxir, "~> 1.0", only: :dev}
    ]
  end

  defp docs do
    [
      main: "readme",
      logo: "guides/images/logo.svg",
      extras: ["README.md", "guides/howtos/Writing PromEx Plugins.md"],
      groups_for_extras: [
        "How-To's": ~r/guides\/howtos\/.?/
      ]
    ]
  end

  defp aliases do
    [
      docs: ["docs", &copy_files/1]
    ]
  end

  defp copy_files(_) do
    # Set up directory structure
    File.mkdir("./doc/guides")
    File.mkdir("./doc/guides/images")

    # Copy over files
    File.cp("./guides/images/logo.svg", "./doc/guides/images/logo.svg")
  end
end
