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
    grafana_auth_token: "<YOUR GRAFANA AUTH TOKEN>"
  ```
  """

  use GenServer, restart: :transient

  require Logger

  alias PromEx.{DashboardRenderer, GrafanaClient, GrafanaClient.Connection}

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
  def init(state) do
    {:ok, state, {:continue, :upload_grafana_dashboards}}
  end

  @impl true
  def handle_continue(:upload_grafana_dashboards, state) do
    %{
      prom_ex_module: prom_ex_module,
      default_dashboard_opts: default_dashboard_opts
    } = state

    %PromEx.Config{
      grafana_config: %{
        host: grafana_host,
        auth_token: grafana_auth_token,
        folder_name: folder_name
      }
    } = prom_ex_module.init_opts()

    # Start Finch process and build Grafana connection
    finch_name = Module.concat([prom_ex_module, __MODULE__, Finch])
    Finch.start_link(name: finch_name)
    grafana_conn = Connection.build(finch_name, grafana_host, grafana_auth_token)

    upload_opts =
      case folder_name do
        :default ->
          []

        folder_name ->
          [folderId: get_folder_id(grafana_conn, folder_name, prom_ex_module)]
      end

    # Iterate over all the configured dashboards and upload them
    prom_ex_module.dashboards()
    |> Enum.each(fn dashboard ->
      dashboard
      |> handle_dashboard_render(default_dashboard_opts, prom_ex_module)
      |> case do
        %DashboardRenderer{valid_json?: true, rendered_file: rendered_dashboard, full_path: full_path} ->
          upload_dashboard(rendered_dashboard, grafana_conn, upload_opts, full_path)

        %DashboardRenderer{full_path: path, error: error} ->
          Logger.info(
            "The dashboard definition for #{inspect(path)} is invalid due to the following error: #{inspect(error)}"
          )
      end
    end)

    # No longer need this short-lived Finch process
    finch_name
    |> Process.whereis()
    |> Process.exit(:normal)

    # Kill the uploader process as there is no more work to do
    {:stop, :normal, :ok}
  end

  defp handle_dashboard_render({otp_app, dashboard_relative_path}, default_assigns, prom_ex_module) do
    handle_dashboard_render({otp_app, dashboard_relative_path, []}, default_assigns, prom_ex_module)
  end

  defp handle_dashboard_render({otp_app, dashboard_relative_path, dashboard_opts}, default_assigns, prom_ex_module) do
    user_provided_assigns = prom_ex_module.dashboard_assigns()

    default_title =
      prom_ex_module.__otp_app__()
      |> Atom.to_string()
      |> Macro.camelize()

    default_dashboard_name =
      dashboard_relative_path
      |> Path.basename()
      |> normalize_file_name()
      |> Macro.camelize()

    default_dashboard_assigns = [
      uid: prom_ex_module.__grafana_dashboard_uid__(otp_app, dashboard_relative_path),
      title: "#{default_title} - PromEx #{default_dashboard_name} Dashboard"
    ]

    otp_app
    |> DashboardRenderer.build(dashboard_relative_path)
    |> DashboardRenderer.merge_assigns(default_assigns)
    |> DashboardRenderer.merge_assigns(user_provided_assigns)
    |> DashboardRenderer.merge_assigns(default_dashboard_assigns)
    |> DashboardRenderer.merge_assigns(dashboard_opts)
    |> DashboardRenderer.render_dashboard()
    |> DashboardRenderer.decode_dashboard()
  end

  defp normalize_file_name(path) do
    if Path.extname(path) == "" do
      path
    else
      path
      |> Path.rootname()
      |> normalize_file_name()
    end
  end

  defp upload_dashboard(dashboard_contents, grafana_conn, upload_opts, full_dashboard_path) do
    case GrafanaClient.upload_dashboard(grafana_conn, dashboard_contents, upload_opts) do
      {:ok, _response_payload} ->
        Logger.info("PromEx.DashboardUploader successfully uploaded #{full_dashboard_path} to Grafana.")

      {:error, reason} ->
        Logger.warn("PromEx.DashboardUploader failed to upload #{full_dashboard_path} to Grafana: #{inspect(reason)}")
    end
  end

  defp get_folder_id(grafana_conn, folder_name, prom_ex_module) do
    folder_uid = prom_ex_module.__grafana_folder_uid__()

    %{"id" => id, "title" => title} =
      case GrafanaClient.get_folder(grafana_conn, folder_uid) do
        {:ok, folder_details} ->
          folder_details

        {:error, :not_found} ->
          {:ok, folder_details} = GrafanaClient.create_folder(grafana_conn, folder_uid, folder_name)
          folder_details

        error ->
          Logger.error(
            "PromEx.DashboardUploader (#{inspect(self())}) failed to retrieve the dashboard folderId from Grafana (#{
              grafana_conn.base_url
            }) because: #{inspect(error)}"
          )

          Process.exit(self(), :normal)
      end

    # Update the folder if the name is not up to date with the config
    if title != folder_name do
      GrafanaClient.update_folder(grafana_conn, folder_uid, folder_name)
    end

    id
  end
end
