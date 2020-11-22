defmodule Mix.Tasks.PromEx.Publish do
  @moduledoc """
  This will publish dashboards to grafana for a PromEx module.
  """

  use Mix.Task

  alias Mix.Project
  alias Mix.Shell.IO
  alias PromEx.{GrafanaClient, GrafanaClient.Connection}

  @impl true
  def run(args) do
    # Compile the project
    Mix.Task.run("compile")
  end
end
