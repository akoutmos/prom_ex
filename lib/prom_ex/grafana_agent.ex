defmodule PromEx.GrafanaAgent do
  @moduledoc """
  This GenServer is responsible for starting the Grafana Agent
  binary via a port and ensurnig that it stays up and running.
  """

  use GenServer

  require Logger

  alias PromEx.GrafanaAgent.Downloader
  alias PromEx.GrafanaAgent.ConfigRenderer

  @doc """
  Start the GrafanaAgent GenServer
  """
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :download_grafana_agent}}
  end

  @impl true
  def handle_continue(:download_grafana_agent, state) do
    do_download_grafana_agent(state)

    {:noreply, state}
  end

  defp do_download_grafana_agent(%{grafana_agent_config: config, prom_ex_module: prom_ex_module}) do
    # Get the root path where all GrafanaAgent related items will reside
    base_directory =
      case Map.fetch(config, :working_directory) do
        {:ok, working_directory} when not is_nil(working_directory) ->
          working_directory

        _ ->
          prom_ex_module.__otp_app__()
          |> :code.priv_dir()
          |> List.to_string()
          |> Kernel.<>("/grafana_agent")
      end

    # Create the necessary directory structure in the base dir
    download_dir = base_directory <> "/download"
    File.mkdir_p!(download_dir)

    bin_dir = base_directory <> "/bin"
    File.mkdir_p!(bin_dir)

    # Download the configured GrafanaAgent binary
    config.version
    |> Downloader.download_grafana_agent(download_dir, bin_dir)
    |> case do
      :ok ->
        Logger.info("GrafanaAgent binary fetched")

      {:error, reason} ->
        raise "Failed to download GrafanaAgent: #{inspect(reason)}"
    end

    # Generate the GrafanaAgent config file
    # ConfigRenderer.
  end
end
