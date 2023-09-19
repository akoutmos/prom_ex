# Configuring Grafana Agent

If you are using Grafana Cloud, you have a couple of options available for sending your metrics. A convenient option to get started easily is to configure the Grafana Agent. Below is an example of the necessary configuration:

```elixir
config :my_app, MyApp.PromEx,
    manual_metrics_start_delay: :no_delay,
    drop_metrics_groups: [],
    grafana: [
      host: System.get_env("GRAFANA_HOST") || raise("GRAFANA_HOST is required"),
      auth_token: System.get_env("GRAFANA_TOKEN") || raise("GRAFANA_TOKEN is required"),
      upload_dashboards_on_start: true,
      folder_name: "MyApp Dashboards",
      annotate_app_lifecycle: true
    ],
    grafana_agent: [
      working_directory: System.get_env("PROM_WORKING_DIRECTORY"),
      config_opts: [
        prometheus_url: System.get_env("PROM_URL"),
        prometheus_username: System.get_env("PROM_USER"),
        prometheus_password: System.get_env("PROM_PASS"),
        metrics_server_scheme: :http
      ]
    ]
```

Take note of the `metrics_server_scheme` attribute; by default, this setting is :https, and often, your services will be running behind a proxy that handles the SSL part. This implies that your service is technically serving http requests, not https. If you encounter this issue, no errors will appear in the logs, making it vital to ensure the correct value is set.

Another useful tip is to maintain access to the Grafana Agent config file. Having this file at hand can facilitate smoother communication with the support team and aid in troubleshooting issues more efficiently.

Upon starting your app, assuming the agent has been correctly configured, the necessary files will be downloaded to the working_directory. You can navigate to this directory to locate the config file at `{working_directory}/config/agent.yml`. Sharing this file with the Grafana Cloud support team can greatly expedite the resolution of any problems you encounter.
