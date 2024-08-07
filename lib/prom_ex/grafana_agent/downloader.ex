defmodule PromEx.GrafanaAgent.Downloader do
  @moduledoc """
  This module is responsible for downloading the GrafanaAgent binary.
  """

  use OctoFetch,
    latest_version: "0.42.0",
    github_repo: "grafana/agent",
    download_versions: %{
      "0.42.0" => [
        {:darwin, :amd64, "0b86ffb8cf1f25897880b71f6028f0666fc3227cb56e7e7b1597452930f4f9b3"},
        {:darwin, :arm64, "b510b1dc46c0f82a3543f56f3ba198e387a69273fd2cba8801832f58985e12a2"},
        {:linux, :amd64, "32acd8d2f1997205c9a87c88503bc40cdf2cb4874291f7f643bcf5741a1c761e"},
        {:linux, :arm64, "eb62450f0e8293e77088034e6e25c3fd2b251cabd2f503600e770530cc7fc08c"},
        {:freebsd, :amd64, "b66eb08b3769748321d1abca80fa85600bdeffd1cd28c5bdf3f0372ca4523ad5"}
      ]
    }

  require Logger

  @impl true
  def download_name(_version, os, arch) do
    "grafana-agent-#{os}-#{arch}.zip"
  end

  @impl true
  def post_write_hook(grafana_agent_file) do
    File.chmod!(grafana_agent_file, 0o755)

    :ok
  end

  @impl true
  def pre_download_hook(_download_file, output_dir) do
    already_downloaded =
      output_dir
      |> File.ls!()
      |> Enum.any?(fn file ->
        Regex.match?(~r/grafana-agent-(?:linux|darwin|freebsd|windows)-(?:amd64|arm64)/, file)
      end)

    if already_downloaded do
      Logger.info("GrafanaAgent binary already present")

      :skip
    else
      :cont
    end
  end
end
