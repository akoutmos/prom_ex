defmodule PromEx.GrafanaClient do
  @moduledoc """
  This module is used by the Mix tasks that are available in PromEx to update
  dashboards in Grafana and also by the `PromEx.DashboardUpdater` to update
  dashboards automatically on application initialization.

  Dashboard models:
  https://grafana.com/docs/grafana/latest/dashboards/json-model/
  """

  require Logger

  alias PromEx.GrafanaClient.Connection

  @status_codes %{
    200 => :ok,
    400 => :bad_request,
    401 => :unauthorized,
    403 => :forbidden,
    404 => :not_found,
    409 => :already_exists,
    412 => :already_exists
  }

  @typep handler_response ::
           {:ok, result :: map()}
           | {:error, reason :: atom()}
           | {:error, reason :: Mint.TransportError.t()}

  @doc false
  @spec child_spec(term) :: Supervisor.child_spec()
  def child_spec(init_arg) do
    Finch.child_spec(init_arg)
  end

  @doc """
  Build a grafana client connection.
  """
  @spec build_conn(prom_ex_module :: module()) :: Connection.t()
  def build_conn(prom_ex_module) do
    name = prom_ex_module.__grafana_client_name__()
    %PromEx.Config{grafana_config: grafana_config} = prom_ex_module.init_opts()
    Connection.build(name, grafana_config)
  end

  @doc """
  Used to create a new dashboard or update an existing dashboard.
  """
  @spec upload_dashboard(
          grafana_conn :: Connection.t(),
          dashboard_file_path :: String.t(),
          opts :: keyword()
        ) ::
          handler_response()
  def upload_dashboard(%Connection{} = grafana_conn, dashboard_contents, opts \\ []) do
    headers = grafana_headers(:post, grafana_conn.authorization)
    payload = generate_payload(dashboard_contents, Keyword.merge(opts, overwrite: true))

    :post
    |> Finch.build("#{grafana_conn.base_url}/api/dashboards/db", headers, payload)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Used to get the dashboard definition currently in Grafana for the provided dashboard file.
  If the ID does not exist in Grafana an error tuple will be returned.
  """
  @spec get_dashboard(grafana_conn :: Connection.t(), dashboard_file_path :: String.t()) ::
          handler_response()
  def get_dashboard(%Connection{} = grafana_conn, dashboard_contents) do
    headers = grafana_headers(:get, grafana_conn.authorization)

    dashboard_uid =
      dashboard_contents
      |> PromEx.JSON.decode!()
      |> Map.get("uid")

    :get
    |> Finch.build("#{grafana_conn.base_url}/api/dashboards/uid/#{dashboard_uid}", headers)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Used to create a new folder in Grafana
  """
  @spec create_folder(
          grafana_conn :: Connection.t(),
          folder_uid :: String.t(),
          title :: String.t()
        ) :: handler_response()
  def create_folder(%Connection{} = grafana_conn, folder_uid, title) do
    headers = grafana_headers(:post, grafana_conn.authorization)

    payload =
      PromEx.JSON.encode!(%{
        uid: folder_uid,
        title: title
      })

    :post
    |> Finch.build("#{grafana_conn.base_url}/api/folders", headers, payload)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Get all of the folder that exist in Grafana
  """
  @spec get_all_folders(grafana_conn :: Connection.t()) :: handler_response()
  def get_all_folders(%Connection{} = grafana_conn) do
    headers = grafana_headers(:get, grafana_conn.authorization)

    :get
    |> Finch.build("#{grafana_conn.base_url}/api/folders", headers)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Update an existing folder in Grafana
  """
  @spec update_folder(
          grafana_conn :: Connection.t(),
          folder_uid :: String.t(),
          new_title :: String.t(),
          attrs :: map()
        ) :: handler_response()
  def update_folder(%Connection{} = grafana_conn, folder_uid, new_title, attrs \\ %{}) do
    headers = grafana_headers(:put, grafana_conn.authorization)

    payload =
      %{
        title: new_title,
        overwrite: true
      }
      |> Map.merge(attrs)
      |> PromEx.JSON.encode!()

    :put
    |> Finch.build("#{grafana_conn.base_url}/api/folders/#{folder_uid}", headers, payload)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Used to fetch the details regarding a particular folder on Grafana
  """
  @spec get_folder(grafana_conn :: Connection.t(), folder_uid :: String.t()) :: handler_response()
  def get_folder(%Connection{} = grafana_conn, folder_id) do
    headers = grafana_headers(:get, grafana_conn.authorization)

    :get
    |> Finch.build("#{grafana_conn.base_url}/api/folders/#{folder_id}", headers)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  @doc """
  Used to create annotations on dashboard panels.

  ## Option Details

  * `:dashboard_id` - Create a dashboard specific annotation. Optional
  * `:panel_id` - Create a panel specific annotation. Optional
  * `:time` - Specify the time of the annotation. When non is supplied the annotation is inferred by grafana. Optional
  * `:time_end` - Specify to great a region annotation. Optional

  """
  @spec create_annotation(
          grafana_conn :: Connection.t(),
          tags :: [String.t()],
          message :: String.t(),
          opts :: keyword()
        ) ::
          handler_response()
  def create_annotation(%Connection{} = grafana_conn, tags, message, opts \\ []) do
    headers = grafana_headers(:post, grafana_conn.authorization)

    payload =
      opts
      |> Keyword.take([:dashboard_id, :panel_id, :time, :time_end])
      |> Enum.into(%{
        tags: tags,
        text: message
      })
      |> Map.new(fn
        {:dashboard_id, v} -> {:dashboardId, v}
        {:panel_id, v} -> {:panelId, v}
        {:time, %DateTime{} = dt} -> {:time, DateTime.to_unix(dt, :millisecond)}
        {:time_end, %DateTime{} = dt} -> {:timeEnd, DateTime.to_unix(dt, :millisecond)}
        {:time_end, v} -> {:timeEnd, v}
        {k, v} -> {k, v}
      end)
      |> PromEx.JSON.encode!()

    :post
    |> Finch.build("#{grafana_conn.base_url}/api/annotations", headers, payload)
    |> Finch.request(grafana_conn.finch_process)
    |> handle_grafana_response()
  end

  defp handle_grafana_response(finch_response) do
    case finch_response do
      {:ok, %Finch.Response{status: status_code, body: body}} when status_code in [200, 201] ->
        {:ok, PromEx.JSON.decode!(body)}

      {:ok, %Finch.Response{status: status_code} = response} ->
        Logger.warning("Received a #{status_code} from Grafana because: #{inspect(response)}")
        {:error, lookup_status_code(status_code)}

      {:error, %Mint.TransportError{} = mint_error_reason} ->
        {:error, Exception.message(mint_error_reason)}

      unknown_response ->
        Logger.warning("Received an unhandled response from Grafana because: #{inspect(unknown_response)}")

        {:error, :unknown}
    end
  end

  defp grafana_headers(:get, authorization) do
    [
      {"authorization", authorization},
      {"accept", "application/json"}
    ]
  end

  defp grafana_headers(action, authorization) when action in [:post, :put] do
    [
      {"authorization", authorization},
      {"content-type", "application/json"},
      {"accept", "application/json"}
    ]
  end

  defp generate_payload(dashboard_definition, opts) do
    dashboard = PromEx.JSON.decode!(dashboard_definition)

    opts
    |> Map.new()
    |> Map.put(:dashboard, dashboard)
    |> PromEx.JSON.encode!()
  end

  defp lookup_status_code(status_code) do
    Map.get(@status_codes, status_code, :unknown)
  end
end
