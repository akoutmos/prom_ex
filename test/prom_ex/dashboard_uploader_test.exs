defmodule PromEx.DashboardUploaderTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias PromEx.DashboardUploader

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.{Application, Beam, Ecto, Phoenix}

    @impl true
    def plugins do
      [
        {Application, otp_app: :prom_ex},
        {Phoenix, router: TestApp.Router, endpoint: TestApp.Endpoint},
        {Beam, poll_rate: 500},
        {Ecto, otp_app: :prom_ex, repos: [Test.Repo]}
      ]
    end

    @impl true
    def dashboard_assigns do
      [
        otp_app: :prom_ex,
        datasource_id: "prometheus"
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  defmodule CustomDashboardApplyFunction do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.{Application, Beam, Ecto, Phoenix}

    @impl true
    def plugins do
      [
        {Application, otp_app: :prom_ex},
        {Phoenix, router: TestApp.Router, endpoint: TestApp.Endpoint},
        {Beam, poll_rate: 500},
        {Ecto, otp_app: :prom_ex, repos: [Test.Repo]}
      ]
    end

    @impl true
    def dashboard_assigns do
      [
        otp_app: :prom_ex,
        datasource_id: "prometheus"
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json", apply_function: &__MODULE__.tweak_dashboard_title/1}]
    end

    @doc false
    def tweak_dashboard_title(dashboard) do
      %{dashboard | "title" => "My really cool custom title"}
    end
  end

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "should handle HTTP errors", %{bypass: bypass} do
    response_payload = """
    {
      "message": "Unauthorized request"
    }
    """

    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        annotate_app_lifecycle: false
      ]
    )

    folder_uid = DefaultPromExSetUp.__grafana_folder_uid__()

    Bypass.expect_once(bypass, "GET", "/api/folders/#{folder_uid}", fn conn ->
      Plug.Conn.resp(conn, 401, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    assert capture_log(fn ->
             {:ok, pid} =
               start_supervised(
                 {
                   DashboardUploader,
                   [
                     name: DefaultPromExSetUp.__dashboard_uploader_name__(),
                     prom_ex_module: DefaultPromExSetUp,
                     default_dashboard_opts: []
                   ]
                 },
                 restart: :temporary
               )

             wait_for_process(pid, 1_000)
           end) =~ "Received a 401 from Grafana because"
  end

  test "should apply any custom functions to the dashboard if provided", %{bypass: bypass} do
    response_payload = """
    {
      "id":1,
      "uid": "nErXDvCkzz",
      "title": "Department ABC",
      "url": "/dashboards/f/nErXDvCkzz/department-abc",
      "hasAcl": false,
      "canSave": true,
      "canEdit": true,
      "canAdmin": true,
      "createdBy": "admin",
      "created": "2018-01-31T17:43:12+01:00",
      "updatedBy": "admin",
      "updated": "2018-01-31T17:43:12+01:00",
      "version": 1
    }
    """

    Application.put_env(:prom_ex, CustomDashboardApplyFunction,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        annotate_app_lifecycle: false
      ]
    )

    folder_uid = CustomDashboardApplyFunction.__grafana_folder_uid__()

    Bypass.expect_once(bypass, "GET", "/api/folders/#{folder_uid}", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "PUT", "/api/folders/#{folder_uid}", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/dashboards/db", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn, [])

      assert body
             |> PromEx.JSON.decode!()
             |> get_in(["dashboard", "title"]) == "My really cool custom title"

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: CustomDashboardApplyFunction.__grafana_client_name__()]},
        restart: :temporary
      )

    assert capture_log(fn ->
             {:ok, pid} =
               start_supervised(
                 {
                   DashboardUploader,
                   [
                     name: CustomDashboardApplyFunction.__dashboard_uploader_name__(),
                     prom_ex_module: CustomDashboardApplyFunction,
                     default_dashboard_opts: []
                   ]
                 },
                 restart: :temporary
               )

             wait_for_process(pid, 1_000)
           end) =~ "PromEx.DashboardUploader successfully uploaded"
  end

  test "should check for existing folders", %{bypass: bypass} do
    response_payload = """
    {
      "id":1,
      "uid": "nErXDvCkzz",
      "title": "Department ABC",
      "url": "/dashboards/f/nErXDvCkzz/department-abc",
      "hasAcl": false,
      "canSave": true,
      "canEdit": true,
      "canAdmin": true,
      "createdBy": "admin",
      "created": "2018-01-31T17:43:12+01:00",
      "updatedBy": "admin",
      "updated": "2018-01-31T17:43:12+01:00",
      "version": 1
    }
    """

    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        annotate_app_lifecycle: false
      ]
    )

    folder_uid = DefaultPromExSetUp.__grafana_folder_uid__()

    Bypass.expect_once(bypass, "GET", "/api/folders/#{folder_uid}", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "PUT", "/api/folders/#{folder_uid}", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/dashboards/db", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    assert capture_log(fn ->
             {:ok, pid} =
               start_supervised(
                 {
                   DashboardUploader,
                   [
                     name: DefaultPromExSetUp.__dashboard_uploader_name__(),
                     prom_ex_module: DefaultPromExSetUp,
                     default_dashboard_opts: []
                   ]
                 },
                 restart: :temporary
               )

             wait_for_process(pid, 1_000)
           end) =~ "PromEx.DashboardUploader successfully uploaded"
  end

  test "should check for new folders", %{bypass: bypass} do
    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        annotate_app_lifecycle: false
      ]
    )

    folder_uid = DefaultPromExSetUp.__grafana_folder_uid__()

    Bypass.expect_once(bypass, "GET", "/api/folders/#{folder_uid}", fn conn ->
      response_payload = """
      {
        "message": "Dashboard not found"
      }
      """

      Plug.Conn.resp(conn, 404, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/folders", fn conn ->
      response_payload = """
      {
        "id":1,
        "uid": "nErXDvCkzz",
        "title": "Web App Dashboards"
      }
      """

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/dashboards/db", fn conn ->
      response_payload = """
      {
        "id":1,
        "uid": "nErXDvCkzz",
        "title": "Department ABC",
        "url": "/dashboards/f/nErXDvCkzz/department-abc",
        "hasAcl": false,
        "canSave": true,
        "canEdit": true,
        "canAdmin": true,
        "createdBy": "admin",
        "created": "2018-01-31T17:43:12+01:00",
        "updatedBy": "admin",
        "updated": "2018-01-31T17:43:12+01:00",
        "version": 1
      }
      """

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    assert capture_log(fn ->
             {:ok, pid} =
               start_supervised(
                 {
                   DashboardUploader,
                   [
                     name: DefaultPromExSetUp.__dashboard_uploader_name__(),
                     prom_ex_module: DefaultPromExSetUp,
                     default_dashboard_opts: []
                   ]
                 },
                 restart: :temporary
               )

             wait_for_process(pid, 1_000)
           end) =~ "PromEx.DashboardUploader successfully uploaded"
  end

  test "should reconcile a diverged UID value for existing folders", %{bypass: bypass} do
    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        annotate_app_lifecycle: false
      ]
    )

    folder_uid = DefaultPromExSetUp.__grafana_folder_uid__()

    Bypass.expect_once(bypass, "GET", "/api/folders/#{folder_uid}", fn conn ->
      response_payload = """
      {
        "message": "Dashboard not found"
      }
      """

      Plug.Conn.resp(conn, 404, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/folders", fn conn ->
      response_payload = """
      {
        "message": "A folder or dashboard in the general folder with the same name already exists",
      }
      """

      Plug.Conn.resp(conn, 409, response_payload)
    end)

    Bypass.expect_once(bypass, "GET", "/api/folders", fn conn ->
      response_payload = """
      [
        {
          "id":1,
          "uid": "nErXDvCkzz",
          "title": "Web App Dashboards"
        },
        {
          "id":1,
          "uid": "asdlkjfu4",
          "title": "Another Dashboards Folder"
        }
      ]
      """

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "PUT", "/api/folders/nErXDvCkzz", fn conn ->
      response_payload = """
      {
        "id":1,
        "uid": "#{folder_uid}",
        "title": "Web App Dashboards"
      }
      """

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    Bypass.expect_once(bypass, "POST", "/api/dashboards/db", fn conn ->
      response_payload = """
      {
        "id":1,
        "uid": "nErXDvCkzz",
        "title": "Department ABC",
        "url": "/dashboards/f/nErXDvCkzz/department-abc",
        "hasAcl": false,
        "canSave": true,
        "canEdit": true,
        "canAdmin": true,
        "createdBy": "admin",
        "created": "2018-01-31T17:43:12+01:00",
        "updatedBy": "admin",
        "updated": "2018-01-31T17:43:12+01:00",
        "version": 1
      }
      """

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    logs =
      capture_log(fn ->
        {:ok, pid} =
          start_supervised(
            {
              DashboardUploader,
              [
                name: DefaultPromExSetUp.__dashboard_uploader_name__(),
                prom_ex_module: DefaultPromExSetUp,
                default_dashboard_opts: []
              ]
            },
            restart: :temporary
          )

        wait_for_process(pid, 1_000)
      end)

    assert logs =~ "There was a folder UID mismatch for the folder titled"
    assert logs =~ "PromEx.DashboardUploader successfully uploaded"
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"

  defp wait_for_process(_pid, timeout) when timeout < 0 do
    flunk("DashboardUploader failed to terminate")
  end

  defp wait_for_process(pid, timeout) do
    if Process.alive?(pid) do
      Process.sleep(100)
      wait_for_process(pid, timeout - 100)
    else
      :ok
    end
  end
end
