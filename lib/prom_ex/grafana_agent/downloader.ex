defmodule PromEx.GrafanaAgent.Downloader do
  @moduledoc """
  This module is responsible for downloading the GrafanaAgent binary.
  """

  use OctoFetch,
    latest_version: "0.23.0",
    github_repo: "grafana/agent",
    download_versions: %{
      "0.29.0" => [
        {:darwin, :amd64, "2b51aab7cfa4daf9b18c857c85dddb9ee9086e7470c3585be661fd6577e15afe"},
        {:darwin, :arm64, "4bf44f44a1e9f4e9c257bea8bcf63549bf4f8f575f8afca94ff0cac371f55ed9"},
        {:linux, :amd64, "aa07cc24de9d607e6388ce85eec76b250f6a4f304ba86ec7e38fc351d9a2739a"},
        {:linux, :arm64, "7d402893564e4054d7e1401d10031b9c2841832a2dab5212184f2b606cd08b0d"},
        {:freebsd, :amd64, "28becd3451ae8d56f4976e87a622da7cd11ce8a02d9bd9f1ee6517785c7fd594"}
      ],
      "0.23.0" => [
        {:darwin, :amd64, "643044b35ed4bdfd9866a43b70e39d64f16709f9685b89a03b299da8834661b0"},
        {:darwin, :arm64, "e94f7fd0e1ef9fb497cff4f1260cc22967d6a5b003dd2c99f494f9e457482dda"},
        {:linux, :amd64, "9c846f8a1f7829f257759d63db6725831d7bfaba36f1689cdb1a12e92bb91b75"},
        {:linux, :arm64, "3b85ce425026302028f7f07d41fa4fc14e9f028ffe7c9067194753cfa719e0d3"},
        {:freebsd, :amd64, "ec067782cc0fcd9c4e951fd6dd0d8013df7f5ed2cd0acb495ab3acfeb6e72b92"}
      ],
      "0.22.0" => [
        {:darwin, :amd64, "1641b70c63fd077a7218b4f7edfca2ef96d103753f6e202611a694306c58ce58"},
        {:darwin, :arm64, "671244ef0f262c71d9194a1db6765a16261d782ebb608df74558219d0a6ef561"},
        {:linux, :amd64, "7d0611f51fa3da042a9d67cabc5fd3b6529dad75368f8858d234719db1b94c55"},
        {:linux, :arm64, "152027ce40072db581fed8c6d58aad5df58b6e8ed2b85858a5df955391db4a8b"},
        {:freebsd, :amd64, "a70d8d268e695906b484d2bd1302d744786571e211ba019e5cef907d4589f82f"}
      ],
      "0.21.2" => [
        {:darwin, :amd64, "cbd8744f0b280a392dc51441818917fdfb7738187a6281c8ab07a0aca0bb6bcb"},
        {:darwin, :arm64, "3148ddfb0fac53d256a0e30cc9ce20e13cf2db02476fe08fd9b4f44521e38bc0"},
        {:linux, :amd64, "2fb5b2017de181ed4cf1b6fbe6813ee490f0e316bb1b3770c566330658f4586d"},
        {:linux, :arm64, "daba91ec861dbc9db22b08f4ef8c70721d5725804a59d5a62040a5decbea79fa"},
        {:freebsd, :amd64, "f5bed6ee6113f6940d9b1a29e3067b6f2e54843e1e292dfc54651374823605f0"}
      ]
    }

  require Logger

  @impl true
  def download_name(_version, os, arch) do
    "agent-#{os}-#{arch}.zip"
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
        Regex.match?(~r/agent-(?:linux|darwin|freebsd|windows)-(?:amd64|arm64)/, file)
      end)

    if already_downloaded do
      Logger.info("GrafanaAgent binary already present")
      :skip
    else
      :cont
    end
  end
end
