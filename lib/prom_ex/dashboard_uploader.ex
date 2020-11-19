defmodule PromEx.DashboardUploader do
  @moduledoc """
  This GenServer is responsible for uploading the configured PromEx module
  dashboards to Grafana. This is a transient process and will terminate after
  the dashboards have been successfully uploaded. It requires the name of the
  PromEx module as an option so that it can look into the application
  config for the appropriate Grafana settings. For example, if the name of the
  PromEx module is `WebApp.PromEx`, then your config chould provide the following
  settings:

  ```elixir
  config :web_app, WebApp.PromEx,
    grafana_host: "<YOUR HOST ADDRESS>",
    grafana_auth_token: "<YOUR GRAFANA AUTH TOKEN>",
    grafana_datasource_id: "<THE ID OF THE PROMETHEUS DATA SOURCE>"
  ```
  """

  use GenServer, restart: :transient

  require Logger

  alias PromEx.{GrafanaClient, GrafanaClient.Connection}

  @doc """
  Used to start the DashboardUploader process
  """
  @spec start_link(opts :: keyword()) :: GenServer.on_start()
  def start_link(opts) do
    {name, remaining_opts} = Keyword.pop(opts, :name)
    state = Map.new(remaining_opts)

    GenServer.start_link(__MODULE__, state, name: name)
  end

  @impl true
  def init(%{prom_ex_module: prom_ex_module}) do
    otp_app = Keyword.fetch!(prom_ex_module.init_opts(), :otp_app)

    state =
      otp_app
      |> Application.get_env(prom_ex_module)
      |> Map.new()
      |> Map.put(:prom_ex_module, prom_ex_module)

    {:ok, state, {:continue, :upload_grafana_dashboards}}
  end

  @impl true
  def handle_continue(:upload_grafana_dashboards, state) do
    %{
      grafana_host: grafana_host,
      grafana_auth_token: grafana_auth_token,
      grafana_datasource_id: _grafana_datasource_id,
      prom_ex_module: prom_ex_module
    } = state

    # Start Finch process and build Grafana connection
    finch_name = Module.concat([prom_ex_module, Finch])
    Finch.start_link(name: finch_name)
    grafana_conn = Connection.build(finch_name, grafana_host, grafana_auth_token)

    # Iterate over all the configured dashboards and upload them
    prom_ex_module.dashboards()
    |> Enum.each(fn
      full_path when is_binary(full_path) ->
        upload_dashboard(full_path, grafana_conn)

      {app, dashboard_path} ->
        priv_path =
          app
          |> :code.priv_dir()
          |> :erlang.list_to_binary()

        priv_path
        |> Path.join(dashboard_path)
        |> upload_dashboard(grafana_conn)
    end)

    # No longer need this short-lived Finch process
    finch_name
    |> Process.whereis()
    |> Process.exit(:normal)

    # Kill the uploader process as there is no more work to do
    {:stop, :normal, :ok}
  end

  defp upload_dashboard(full_dashboard_path, grafana_conn) do
    case GrafanaClient.upload_dashboard(grafana_conn, full_dashboard_path) do
      {:ok, _response_payload} ->
        Logger.info("PromEx.DashboardUploader successfully uploaded #{full_dashboard_path} to Grafana.")

      {:error, reason} ->
        Logger.warn("PromEx.DashboardUploader failed to upload #{full_dashboard_path} to Grafana: #{inspect(reason)}")
    end
  end
end
