defmodule PromEx.GrafanaAgent.DownloaderTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureLog

  alias PromEx.GrafanaAgent.Downloader

  @download_timeout 10_000

  describe "download/2" do
    test "should be able to download all of the listed versions" do
      OctoFetch.Test.test_all_supported_downloads(Downloader)
    end

    @tag :tmp_dir
    test "should return an error if an invalid version is provided", %{tmp_dir: tmp_dir} do
      assert capture_log(fn ->
               assert {:error, "invalid_version is not a supported version"} =
                        Downloader.download(tmp_dir, override_version: "invalid_version")
             end) =~ "Failed to download release from GitHub. invalid_version is not a supported version"
    end

    @tag :tmp_dir
    test "should download the file the first time and use the filesystem the second time", %{tmp_dir: tmp_dir} do
      {os, arch} = get_system_arch()

      assert capture_log(fn ->
               assert {:ok, [_output_path], []} = Downloader.download(tmp_dir)
             end) =~ "Downloading grafana/agent from https://github.com/grafana/agent/releases/download"

      assert tmp_dir
             |> File.ls!()
             |> Enum.sort() == ["grafana-agent-#{os}-#{arch}"]

      assert capture_log(fn ->
               assert :skip = Downloader.download(tmp_dir)
             end) =~ "GrafanaAgent binary already present"

      assert tmp_dir
             |> File.ls!()
             |> Enum.sort() == ["grafana-agent-#{os}-#{arch}"]
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
            assert {:ok, [_output_path], []} = Downloader.download(a_dir)
          end)
        end)

      downloader_b =
        Task.async(fn ->
          capture_log(fn ->
            assert {:ok, [_output_path], []} = Downloader.download(b_dir)
          end)
        end)

      assert Task.await(downloader_a, @download_timeout) =~
               "Downloading grafana/agent from https://github.com/grafana/agent/releases/download"

      assert Task.await(downloader_b, @download_timeout) =~
               "Downloading grafana/agent from https://github.com/grafana/agent/releases/download"

      assert a_dir
             |> File.ls!()
             |> Enum.sort() == ["grafana-agent-#{os}-#{arch}"]

      assert b_dir
             |> File.ls!()
             |> Enum.sort() == ["grafana-agent-#{os}-#{arch}"]
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
