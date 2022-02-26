defmodule PromEx.GrafanaAgent do
  @moduledoc """
  This GenServer is responsible for starting the Grafana Agent
  binary via a port and ensurnig that it stays up and running.
  """

  use GenServer

  require Logger

  alias PromEx.GrafanaAgent.ConfigRenderer
  alias PromEx.GrafanaAgent.Downloader

  @doc """
  Start the GrafanaAgent GenServer
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop!(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :start_grafana_agent}}
  end

  @impl true
  def handle_continue(:start_grafana_agent, state) do
    # Download the GrafanaAgent binary and get the path to the binary
    binary_path = do_download_grafana_agent(state)

    # Render the config file for GrafanaAgent
    config_file_path = do_generate_config(state)

    # Port wrapper path
    port_wrapper_path =
      :prom_ex
      |> :code.priv_dir()
      |> List.to_string()
      |> Path.join("/grafana_agent/port_wrapper.sh")

    state =
      state
      |> Map.put(:binary_path, binary_path)
      |> Map.put(:port_wrapper_path, port_wrapper_path)
      |> Map.put(:config_file_path, config_file_path)

    start_agent(state)

    {:noreply, state}
  end

  @impl true
  def handle_info({_port, {:data, stdout}}, state) do
    Logger.info("Grafana Agent log: #{inspect(String.trim(stdout))}")

    {:noreply, state}
  end

  def handle_info({_port, {:exit_status, exit_status}}, state) do
    Logger.warning("GrafanaAgent has terminated with an exit status of #{exit_status}")
    Process.sleep(5_000)

    port = start_agent(state)
    state = Map.put(state, :port, port)

    {:noreply, state}
  end

  defp start_agent(%{port_wrapper_path: port_wrapper_path, binary_path: binary_path, config_file_path: config_file_path}) do
    Logger.info("Starting GrafanaAgent")

    {:spawn_executable, port_wrapper_path}
    |> Port.open([
      :binary,
      :exit_status,
      :stderr_to_stdout,
      args: [binary_path, "-config.file", config_file_path]
    ])
  end

  defp get_base_directory(%{grafana_agent_config: config, prom_ex_module: prom_ex_module}) do
    case Map.fetch(config, :working_directory) do
      {:ok, working_directory} when not is_nil(working_directory) ->
        working_directory

      _ ->
        prom_ex_module.__otp_app__()
        |> :code.priv_dir()
        |> List.to_string()
        |> Path.join("/grafana_agent")
    end
  end

  defp do_download_grafana_agent(%{grafana_agent_config: config} = state) do
    # Get the root path where all GrafanaAgent related items will reside
    base_directory = get_base_directory(state)

    # Create the necessary directory structure in the base dir
    download_dir = Path.join(base_directory, "/download")
    File.mkdir_p!(download_dir)

    bin_dir = Path.join(base_directory, "/bin")
    File.mkdir_p!(bin_dir)

    # Download the configured GrafanaAgent binary
    config.version
    |> Downloader.download_grafana_agent(download_dir, bin_dir)
    |> case do
      {:ok, binary_path} ->
        binary_path

      {:error, reason} ->
        raise "Failed to download GrafanaAgent: #{inspect(reason)}"
    end
  end

  defp do_generate_config(state) do
    # Get the root path where all GrafanaAgent related items will reside
    base_directory = get_base_directory(state)

    # Create the necessary directory structure in the base dir
    config_dir = Path.join(base_directory, "/config")
    File.mkdir_p!(config_dir)

    # Create the necessary directory structure in the base dir
    wal_dir = Path.join(base_directory, "/prom_wal")
    File.mkdir_p!(wal_dir)

    state
    |> Map.get(:grafana_agent_config)
    |> Map.get(:config_opts)
    |> Map.put(:wal_dir, wal_dir)
    |> maybe_put_job(state)
    |> maybe_put_instance()
    |> ConfigRenderer.generate_config_file(config_dir)
  end

  defp maybe_put_job(%{job: nil} = opts, state) do
    Map.put(opts, :job, state.prom_ex_module.__otp_app__())
  end

  defp maybe_put_job(opts, _state) do
    opts
  end

  defp maybe_put_instance(%{instance: nil} = opts) do
    # Get the hostname for the instance
    {:ok, hostname} = :inet.gethostname()

    Map.put(opts, :instance, hostname)
  end

  defp maybe_put_instance(opts) do
    opts
  end
end
