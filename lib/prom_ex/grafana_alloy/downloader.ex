defmodule PromEx.GrafanaAlloy.Downloader do
  @moduledoc """
  This module is responsible for downloading the Grafana Alloy binary.
  """

  use OctoFetch,
    latest_version: "1.13.2",
    github_repo: "grafana/alloy",
    download_versions: %{
      "1.13.2" => [
        {:darwin, :amd64, "3eaeb93a0fa3c967a78ed5172dab35b00e6d99ab15014650c1b48c31be50d827"},
        {:darwin, :arm64, "678262eb7ce0420d8d7f9d2ff61a99a023921cdeea2c604b79f84340eeee3e12"},
        {:linux, :amd64, "6f256a84d80005d2e31a6ef93015d6e17404c79f5185f12d8692ad6611b670e0"},
        {:linux, :arm64, "bde666b1e02500e50a2503e25f1a6211ebf8e7df95afd7bb81cce851fbd0d647"},
        {:freebsd, :amd64, "591439055b2eae6e317ec61a432962b52b271c5a5ecf0f6c0aa1388fd8ff1d61"}
      ]
    }

  require Logger

  @impl true
  def download_name(_version, os, arch) do
    "alloy-#{os}-#{arch}.zip"
  end

  @impl true
  def post_write_hook(grafana_alloy_file) do
    File.chmod!(grafana_alloy_file, 0o755)

    :ok
  end

  @impl true
  def pre_download_hook(_download_file, output_dir) do
    already_downloaded =
      output_dir
      |> File.ls!()
      |> Enum.any?(fn file ->
        Regex.match?(~r/alloy-(?:linux|darwin|freebsd|windows)-(?:amd64|arm64)/, file)
      end)

    if already_downloaded do
      Logger.info("Grafana Alloy binary already present")

      :skip
    else
      :cont
    end
  end
end
