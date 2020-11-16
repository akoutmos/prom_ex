defmodule Mix.Tasks.PromEx.Gen.Config do
  @moduledoc """
  This will generate a PromEx config
  """

  use Mix.Task

  alias Mix.Project
  alias Mix.Shell.IO

  @impl true
  def run(_args) do
    Mix.Task.run("compile")

    app_priv_dir =
      Project.config()
      |> Keyword.get(:app)
      |> :code.priv_dir()
      |> :erlang.list_to_binary()

    grafana_dashboards_dir = Path.join([app_priv_dir, "grafana_dashboards"])

    unless File.exists?(grafana_dashboards_dir) do
      IO.info("Creating Grafana dashboards directory")
      File.mkdir(grafana_dashboards_dir)
    end

    prom_ex_config_file = Path.join([grafana_dashboards_dir, ".prom_ex.exs"])

    create_file =
      if File.exists?(prom_ex_config_file) do
        IO.yes?("An existing PromEx config file already exists. Overwrite?")
      else
        true
      end

    if create_file do
      create_config_file(prom_ex_config_file)
      IO.info("Successfully Created .prom_ex.exs config file")
    else
      IO.info("Did not create .prom_ex.exs file")
    end
  end

  defp create_config_file(path) do
    path
    |> File.write!("""
    %{
      dashboards: [
        # PromEx built in dashboard definitions. Remove dashboards
        # that you do not need.
        {:prom_ex, "/grafana_dashboards/application.json"},
        {:prom_ex, "/grafana_dashboards/beam.json"},
        {:prom_ex, "/grafana_dashboards/phoenix.json"}

        # Add your dashboard definitions here
        # {:my_app, "/grafana_dashboards/business_related_metrics.json"}
      ]
    }
    """)
  end
end
