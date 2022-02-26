defmodule PromEx.GrafanaAgent.ConfigRendererTest do
  use ExUnit.Case, async: true

  alias PromEx.GrafanaAgent.ConfigRenderer

  describe "generate_config_file/2" do
    @tag :tmp_dir
    test "should generate a configuration yaml file with the correct substitutions", %{tmp_dir: tmp_dir} do
      template_args = %{
        agent_port: "12345",
        log_level: "error",
        wal_dir: "/tmp/test/wal",
        scrape_interval: "5s",
        job: "TestApp",
        metrics_server_path: "/cool-metrics",
        metrics_server_scheme: :https,
        metrics_server_host: "localhost",
        bearer_token: "super_secret",
        metrics_server_port: "1234",
        instance: "localhost",
        prometheus_url: "www.my-prometheus.com",
        prometheus_username: "prom_user",
        prometheus_password: "prom_pass"
      }

      ConfigRenderer.generate_config_file(template_args, tmp_dir)
      expected_file_path = "#{tmp_dir}/agent.yml"

      assert File.exists?(expected_file_path)
      assert File.read!(expected_file_path) == File.read!("#{__DIR__}/expected_output_config.yml")
    end
  end
end
