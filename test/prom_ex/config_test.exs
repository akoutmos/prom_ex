defmodule PromEx.ConfigTest do
  use ExUnit.Case, async: true

  alias PromEx.Config

  describe "build/1" do
    test "should return a valid config struct if no options are passed" do
      assert %PromEx.Config{
               disabled: false,
               drop_metrics_groups: %MapSet{},
               grafana_agent_config: :disabled,
               grafana_config: :disabled,
               manual_metrics_start_delay: :no_delay,
               metrics_server_config: :disabled
             } = Config.build([])
    end

    test "should generate a valid config if all the Grafana options are provided" do
      config =
        Config.build(
          grafana: [
            host: "https://my-grafana-instance.com/",
            auth_token: "super_secret",
            folder_name: "My Dashboards",
            upload_dashboards_on_start: true,
            annotate_app_lifecycle: true
          ]
        )

      assert %PromEx.Config{
               disabled: false,
               drop_metrics_groups: %MapSet{},
               grafana_agent_config: :disabled,
               grafana_config: %{
                 annotate_app_lifecycle: true,
                 auth_token: "super_secret",
                 folder_name: "My Dashboards",
                 host: "https://my-grafana-instance.com",
                 password: nil,
                 upload_dashboards_on_start: true,
                 username: nil,
                 finch_pools: nil
               },
               manual_metrics_start_delay: :no_delay,
               metrics_server_config: :disabled
             } = config
    end

    test "should generate default grafana agent config" do
      config =
        Config.build(
          grafana_agent: [
            config_opts: [
              prometheus_url: "https://prometheus",
              prometheus_username: "prometheus-user",
              prometheus_password: "prometheus-password"
            ]
          ]
        )

      assert %PromEx.Config{
               grafana_agent_config: %{
                 config_opts: %{
                   prometheus_url: "https://prometheus",
                   prometheus_username: "prometheus-user",
                   prometheus_password: "prometheus-password",
                   scrape_interval: "15s",
                   bearer_token: "blank",
                   log_level: "error",
                   agent_port: "12345",
                   grpc_port: "123456",
                   job: nil,
                   instance: nil,
                   metrics_server_path: "/metrics",
                   metrics_server_port: 4000,
                   metrics_server_host: "localhost",
                   metrics_server_scheme: :https
                 }
               }
             } = config
    end

    test "should override existing keys, and pass additional keys to grafana agent config" do
      config =
        Config.build(
          grafana_agent: [
            config_opts: [
              prometheus_url: "https://prometheus",
              prometheus_username: "prometheus-user",
              prometheus_password: "prometheus-password",
              agent_port: "4141",
              template_file: "path/to/template",
              foo: "bar"
            ]
          ]
        )

      assert %PromEx.Config{
               grafana_agent_config: %{
                 config_opts: %{
                   # required
                   prometheus_url: "https://prometheus",
                   prometheus_username: "prometheus-user",
                   prometheus_password: "prometheus-password",

                   # default
                   scrape_interval: "15s",

                   # override
                   agent_port: "4141",

                   # new keys
                   template_file: "path/to/template",
                   foo: "bar"
                 }
               }
             } = config
    end

    test "should raise an error if there are missing standalone metrics server fields" do
      assert_raise RuntimeError, "When configuring the PromEx metrics server, the :port key is required.", fn ->
        Config.build(metrics_server: [])
      end
    end

    test "should raise an error if there is an invalid auth method defined" do
      assert_raise RuntimeError,
                   "Unknown auth strategy provided to PromEx metrics server. Supported strategies include :none, :bearer, or :basic.",
                   fn ->
                     Config.build(metrics_server: [port: 8080, auth_strategy: :invalid])
                   end
    end

    test "should raise an error if there are missing Grafana fields" do
      assert_raise RuntimeError, "When configuring the Grafana client for PromEx, the :host key is required.", fn ->
        Config.build(
          grafana: [
            auth_token: "super_secret",
            folder_name: "My Dashboards",
            upload_dashboards_on_start: true,
            annotate_app_lifecycle: true
          ]
        )
      end
    end

    test "should return the Config struct if all the options are valid" do
      Config.build(
        grafana_agent: [
          version: {"0.23.0", :linux, :amd64},
          config_opts: [
            prometheus_url: "https://my-prom-instance.com/",
            prometheus_username: "prom_user",
            prometheus_password: "prom_pass"
          ]
        ]
      )
    end
  end
end
