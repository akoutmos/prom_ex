defmodule PromEx.MixProject do
  use Mix.Project

  def project do
    [
      app: :prom_ex,
      version: "0.1.14-beta",
      elixir: "~> 1.10",
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
        plt_add_apps: [:ecto, :mix, :oban, :phoenix, :plug, :telemetry_metrics],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      package: package(),
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

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # Required dependencies
      {:jason, "~> 1.2"},
      {:finch, "~> 0.5.2"},
      {:telemetry, "~> 0.4.2"},
      {:telemetry_poller, "~> 0.5.1"},
      {:telemetry_metrics, "~> 0.6.0"},
      {:plug_cowboy, "~> 2.1"},

      # Optional dependencies depending on what telemetry events the user is interested in capturing
      {:phoenix, ">= 1.5.0", optional: true},
      {:phoenix_live_view, ">= 0.14.0", optional: true},
      {:plug, ">= 1.10.0", optional: true},
      {:ecto, ">= 3.5.0", optional: true},
      {:oban, ">= 2.4.0", optional: true},

      # PromEx development related dependencies
      {:bypass, "~> 2.1", only: :test},
      {:ex_doc, "~> 0.22", only: :dev},
      {:excoveralls, "~> 0.13.3", only: :test, runtime: false},
      {:doctor, "~> 0.15.0", only: :dev},
      {:credo, "~> 1.5.1", only: :dev},
      {:dialyxir, "~> 1.0", only: :dev, runtime: false},
      {:git_hooks, "~> 0.5.0", only: [:test, :dev], runtime: false}
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

  defp package do
    [
      name: "prom_ex",
      files: ~w(lib priv/*.eex mix.exs README.md LICENSE CHANGELOG.md),
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/akoutmos/prom_ex",
        "Sponsor" => "https://github.com/sponsors/akoutmos"
      }
    ]
  end

  defp aliases do
    [
      docs: ["docs", &copy_files/1]
    ]
  end

  defp copy_files(_) do
    # Set up directory structure
    File.mkdir_p!("./doc/guides/images")

    # Copy over files
    File.cp!("./guides/images/logo.svg", "./doc/guides/images/logo.svg")
    File.cp!("./guides/images/apache_bench_stress_test.png", "./doc/guides/images/apache_bench_stress_test.png")
    File.cp!("./guides/images/dashboards_preview.png", "./doc/guides/images/dashboards_preview.png")
  end
end
