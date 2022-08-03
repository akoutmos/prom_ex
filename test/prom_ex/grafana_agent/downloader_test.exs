defmodule PromEx.GrafanaAgent.DownloaderTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureLog

  alias PromEx.GrafanaAgent.Downloader

  describe "download_grafana_agent/3" do
    @tag :tmp_dir
    test "should raise if an invalid arch is provided", %{tmp_dir: tmp_dir} do
      expected_error =
        ~s(Invalid GrafanaAgent version provided. Supported version are: ["0.23.0", "0.22.0", "0.21.2", "0.20.1"])

      assert_raise RuntimeError, expected_error, fn ->
        {"invalid_version"}
        |> Downloader.download_grafana_agent(tmp_dir, tmp_dir, PromEx.Agent)
      end
    end

    @tag :tmp_dir
    test "should download the file the first time and use the filesystem the second time", %{tmp_dir: tmp_dir} do
      {os, arch} = get_system_arch()

      assert capture_log(fn ->
               assert {:ok, _output_path} =
                        Downloader.latest_version()
                        |> Downloader.download_grafana_agent(tmp_dir, tmp_dir, PromEx.Agent)
             end) =~ "Fetching GrafanaAgent zip archive"

      assert tmp_dir
             |> File.ls!()
             |> Enum.sort() == ["agent-#{os}-#{arch}", "agent-#{os}-#{arch}.zip"]

      assert capture_log(fn ->
               assert {:ok, _output_path} =
                        Downloader.latest_version()
                        |> Downloader.download_grafana_agent(tmp_dir, tmp_dir, PromEx.Agent)
             end) =~ "GrafanaAgent zip archive already present"

      assert tmp_dir
             |> File.ls!()
             |> Enum.sort() == ["agent-#{os}-#{arch}", "agent-#{os}-#{arch}.zip"]
    end

    @tag :tmp_dir
    test "should download multiple agents in parallel", %{tmp_dir: tmp_dir} do
      {os, arch} = get_system_arch()

      a_dir = "#{tmp_dir}/a"
      b_dir = "#{tmp_dir}/b"
      File.mkdir!(a_dir)
      File.mkdir!(b_dir)

      downloader_a =
        Task.async(fn ->
          capture_log(fn ->
            assert {:ok, _output_path} =
                     Downloader.latest_version()
                     |> Downloader.download_grafana_agent(a_dir, a_dir, PromEx.AgentA)
          end)
        end)

      downloader_b =
        Task.async(fn ->
          capture_log(fn ->
            assert {:ok, _output_path} =
                     Downloader.latest_version()
                     |> Downloader.download_grafana_agent(b_dir, b_dir, PromEx.AgentB)
          end)
        end)

      assert Task.await(downloader_a) =~ "Fetching GrafanaAgent zip archive"
      assert Task.await(downloader_b) =~ "Fetching GrafanaAgent zip archive"

      assert a_dir
             |> File.ls!()
             |> Enum.sort() == ["agent-#{os}-#{arch}", "agent-#{os}-#{arch}.zip"]

      assert b_dir
             |> File.ls!()
             |> Enum.sort() == ["agent-#{os}-#{arch}", "agent-#{os}-#{arch}.zip"]
    end
  end

  defp get_system_arch do
    arch_str = :erlang.system_info(:system_architecture)
    [arch | _] = arch_str |> List.to_string() |> String.split("-")

    case {:os.type(), arch, :erlang.system_info(:wordsize) * 8} do
      {{:unix, :darwin}, arch, 64} when arch in ~w(arm aarch64) -> {:darwin, :arm64}
      {{:unix, :darwin}, "x86_64", 64} -> {:darwin, :amd64}
      {{:unix, :linux}, "aarch64", 64} -> {:linux, :arm64}
      {{:unix, :freebsd}, "amd64", 64} -> {:freebsd, :amd64}
      {{:unix, _osname}, arch, 64} when arch in ~w(x86_64 amd64) -> {:linux, :amd64}
    end
  end
end
