defmodule PromEx.GrafanaAlloy do
  @moduledoc """
  This GenServer is responsible for starting the Grafana Alloy
  binary via a port and ensuring that it stays up and running.
  """

  use GenServer

  require Logger

  alias PromEx.GrafanaAlloy.ConfigRenderer
  alias PromEx.GrafanaAlloy.Downloader

  @doc """
  Start the GrafanaAlloy GenServer
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop!(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl true
  def init(state) do
    {:ok, state, {:continue, :start_grafana_alloy}}
  end

  @impl true
  def handle_continue(:start_grafana_alloy, state) do
    # Download the Grafana Alloy binary and get the path to the binary
    binary_path = do_download_grafana_alloy(state)

    # Render the config file for Grafana Alloy
    config_file_path = do_generate_config(state)

    # Port wrapper path
    port_wrapper_path =
      :prom_ex
      |> :code.priv_dir()
      |> List.to_string()
      |> Path.join("/grafana_alloy/port_wrapper.sh")

    state =
      state
      |> Map.put(:binary_path, binary_path)
      |> Map.put(:port_wrapper_path, port_wrapper_path)
      |> Map.put(:config_file_path, config_file_path)

    start_alloy(state)

    {:noreply, state}
  end

  @impl true
  def handle_info({_port, {:data, stdout}}, state) do
    Logger.info("Grafana Alloy log: #{inspect(String.trim(stdout))}")

    {:noreply, state}
  end

  def handle_info({_port, {:exit_status, exit_status}}, state) do
    Logger.warning("Grafana Alloy has terminated with an exit status of #{exit_status}")
    Process.sleep(5_000)

    port = start_alloy(state)
    state = Map.put(state, :port, port)

    {:noreply, state}
  end

  defp start_alloy(
         %{
           port_wrapper_path: port_wrapper_path,
           binary_path: binary_path,
           config_file_path: config_file_path
         } = state
       ) do
    Logger.info("Starting Grafana Alloy")

    wrapper_args = [
      binary_path,
      "run",
      config_file_path
    ]

    {:spawn_executable, port_wrapper_path}
    |> Port.open([
      :binary,
      :exit_status,
      :stderr_to_stdout,
      args: wrapper_args
    ])
  end

  defp get_base_directory(%{grafana_alloy_config: config, prom_ex_module: prom_ex_module}) do
    case Map.fetch(config, :working_directory) do
      {:ok, working_directory} when not is_nil(working_directory) ->
        working_directory

      _ ->
        prom_ex_module.__otp_app__()
        |> :code.priv_dir()
        |> List.to_string()
        |> Path.join("/grafana_alloy")
    end
  end

  defp do_download_grafana_alloy(%{grafana_alloy_config: config} = state) do
    # Get the root path where all Grafana Alloy related items will reside
    base_directory = get_base_directory(state)

    # Create the necessary directory structure in the base dir
    bin_dir = Path.join(base_directory, "/bin")
    File.mkdir_p!(bin_dir)

    # Download the configured Grafana Alloy binary
    bin_dir
    |> Downloader.download(override_version: config.version)
    |> case do
      {:ok, [binary_path], []} ->
        binary_path

      {:error, reason} ->
        raise "Failed to download Grafana Alloy: #{inspect(reason)}"

      :skip ->
        derive_existing_bin_path(bin_dir)
    end
  end

  defp derive_existing_bin_path(bin_dir) do
    bin_dir
    |> File.ls!()
    |> Enum.find_value(fn file ->
      if Regex.match?(~r/alloy-(?:linux|darwin|freebsd|windows)-(?:amd64|arm64)/, file) do
        Path.join(bin_dir, file)
      else
        nil
      end
    end)
  end

  defp do_generate_config(state) do
    # Get the root path where all Grafana Alloy related items will reside
    base_directory = get_base_directory(state)

    # Create the necessary directory structure in the base dir
    wal_dir = Path.join(base_directory, "/prom_wal")
    File.mkdir_p!(wal_dir)

    state
    |> Map.get(:grafana_alloy_config)
    |> Map.get(:config_opts)
    |> case do
      {module, function, arguments} ->
        apply(module, function, arguments)

      config_opts ->
        # Create the necessary directory structure in the base dir
        config_dir = Path.join(base_directory, "/config")
        File.mkdir_p!(config_dir)

        config_opts
        |> Map.put(:wal_dir, wal_dir)
        |> maybe_put_job(state)
        |> maybe_put_instance()
        |> ConfigRenderer.generate_config_file(config_dir)
    end
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
