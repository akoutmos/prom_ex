defmodule PromEx.GrafanaAgent.Downloader do
  @moduledoc """
  This module is responsible for downloading the GrafanaAgent binary.
  """

  require Logger

  @latest_grafana_agent_version "0.23.0"
  @supported_grafana_agent_versions ["0.23.0", "0.22.0", "0.21.2", "0.20.1"]

  @valid_agent_versions %{
    # All the SHA hashes for version 0.23.0
    {"0.23.0", :darwin, :amd64} => "643044b35ed4bdfd9866a43b70e39d64f16709f9685b89a03b299da8834661b0",
    {"0.23.0", :darwin, :arm64} => "e94f7fd0e1ef9fb497cff4f1260cc22967d6a5b003dd2c99f494f9e457482dda",
    {"0.23.0", :linux, :amd64} => "9c846f8a1f7829f257759d63db6725831d7bfaba36f1689cdb1a12e92bb91b75",
    {"0.23.0", :linux, :arm64} => "3b85ce425026302028f7f07d41fa4fc14e9f028ffe7c9067194753cfa719e0d3",

    # All the SHA hashes for version 0.22.0
    {"0.22.0", :darwin, :amd64} => "1641b70c63fd077a7218b4f7edfca2ef96d103753f6e202611a694306c58ce58",
    {"0.22.0", :darwin, :arm64} => "671244ef0f262c71d9194a1db6765a16261d782ebb608df74558219d0a6ef561",
    {"0.22.0", :linux, :amd64} => "7d0611f51fa3da042a9d67cabc5fd3b6529dad75368f8858d234719db1b94c55",
    {"0.22.0", :linux, :arm64} => "152027ce40072db581fed8c6d58aad5df58b6e8ed2b85858a5df955391db4a8b",

    # All the SHA hashes for version 0.21.2
    {"0.21.2", :darwin, :amd64} => "cbd8744f0b280a392dc51441818917fdfb7738187a6281c8ab07a0aca0bb6bcb",
    {"0.21.2", :darwin, :arm64} => "3148ddfb0fac53d256a0e30cc9ce20e13cf2db02476fe08fd9b4f44521e38bc0",
    {"0.21.2", :linux, :amd64} => "2fb5b2017de181ed4cf1b6fbe6813ee490f0e316bb1b3770c566330658f4586d",
    {"0.21.2", :linux, :arm64} => "daba91ec861dbc9db22b08f4ef8c70721d5725804a59d5a62040a5decbea79fa",

    # All the SHA hashes for version 0.20.1
    {"0.20.1", :darwin, :amd64} => "ada22a835742f9a89e39bc2fbf31de2d876e597b8813fd2c51decf1b2bc8b858",
    {"0.20.1", :darwin, :arm64} => "a62d7ee2397aedb5d85abf6fa9376132cee2097c2e7b00f5a3c66ae967997107",
    {"0.20.1", :linux, :amd64} => "d62f6cc8c9fb35bcb19486c6c4c07b100edfb25eb3fb223230c0e1dd302c7d11",
    {"0.20.1", :linux, :arm64} => "d96bd5ac1fbeceb0d96c648f84a7f4a98ff89557602e732ac5d6feaea4f2f334"
  }

  defguardp is_valid_version(version) when version in @supported_grafana_agent_versions

  @doc """
  This function will download the desired GrafanaAgent binary and store it in the
  proided GrafanaAgent directory.
  """
  @spec download_grafana_agent(
          version :: String.t(),
          download_directory :: String.t(),
          bin_directory :: String.t()
        ) :: {:ok, String.t()} | {:error, String.t()}
  def download_grafana_agent(agent_version, download_directory, bin_directory) when is_valid_version(agent_version) do
    agent_version = get_download_version(agent_version)
    download_url = build_download_url(agent_version)

    zip_file_name =
      download_url
      |> URI.parse()
      |> Map.get(:path)
      |> Path.basename()

    binary_file_name =
      zip_file_name
      |> String.trim_trailing(".zip")

    # Set constants for where files will be located
    zip_download_path = "#{download_directory}/#{zip_file_name}"
    binary_path = "#{bin_directory}/#{binary_file_name}"

    # Download the agent, verify it, and unzip it
    with :ok <- do_download_grafana_agent(download_url, zip_download_path),
         :ok <- verify_zip_download(zip_download_path, agent_version) do
      unzip_grafana_agent(zip_download_path, binary_path)
    end
  end

  def download_grafana_agent(_agent_version, _, _) do
    raise "Invalid GrafanaAgent version provided. Supported version are: #{inspect(@supported_grafana_agent_versions)}"
  end

  @doc """
  Get the latest version of GrafanaAgent (that PromEx supports).
  """
  @spec latest_version :: String.t()
  def latest_version do
    @latest_grafana_agent_version
  end

  defp get_download_version(agent_version) do
    arch_str = :erlang.system_info(:system_architecture)
    [arch | _] = arch_str |> List.to_string() |> String.split("-")

    case {:os.type(), arch, :erlang.system_info(:wordsize) * 8} do
      {{:unix, :darwin}, arch, 64} when arch in ~w(arm aarch64) -> {agent_version, :darwin, :arm64}
      {{:unix, :darwin}, "x86_64", 64} -> {agent_version, :darwin, :amd64}
      {{:unix, :linux}, "aarch64", 64} -> {agent_version, :linux, :arm64}
      {{:unix, _osname}, arch, 64} when arch in ~w(x86_64 amd64) -> {agent_version, :linux, :amd64}
      unsupported_arch -> raise "Unsupported architecture: #{inspect(unsupported_arch)}"
    end
  end

  defp unzip_grafana_agent(zip_download_path, binary_path) do
    # Extract the zip file
    zip_contents = File.read!(zip_download_path)
    {:ok, [{_file_name, unzipped_contents}]} = :zip.extract(zip_contents, [:memory])

    # Set exec permissions to GrafanaAgent
    File.write(binary_path, unzipped_contents)
    File.chmod!(binary_path, 0o755)

    {:ok, binary_path}
  end

  defp verify_zip_download(zip_download_path, agent_version) do
    # Get the known SHA256 value
    known_sha = Map.fetch!(@valid_agent_versions, agent_version)

    # Read the zip file and compute the SHA256 value
    zip_contents = File.read!(zip_download_path)

    computed_sha =
      :sha256
      |> :crypto.hash(zip_contents)
      |> Base.encode16()
      |> String.downcase()

    if known_sha == computed_sha do
      :ok
    else
      {:error, "Invalid SHA256 value computed for #{zip_download_path}"}
    end
  end

  defp build_download_url({version, os, arch}) do
    "https://github.com/grafana/agent/releases/download/v#{version}/agent-#{os}-#{arch}.zip"
  end

  defp do_download_grafana_agent(download_url, zip_file_path) do
    if File.exists?(zip_file_path) do
      Logger.info("GrafanaAgent zip archive already present")

      :ok
    else
      Logger.info("Fetching GrafanaAgent zip archive")

      {:ok, finch_pid} = Finch.start_link(name: __MODULE__.AgentFetcher)

      {:ok, %Finch.Response{headers: headers}} =
        :get
        |> Finch.build(download_url)
        |> Finch.request(__MODULE__.AgentFetcher)

      {_, redirect_url} =
        Enum.find(headers, fn
          {"location", _} -> true
          _ -> false
        end)

      # Download and extract the zip file contents
      {:ok, %Finch.Response{body: body}} =
        :get
        |> Finch.build(redirect_url)
        |> Finch.request(__MODULE__.AgentFetcher)

      File.write!(zip_file_path, body)

      # Kill the Finch process
      Process.exit(finch_pid, :normal)

      :ok
    end
  end
end
