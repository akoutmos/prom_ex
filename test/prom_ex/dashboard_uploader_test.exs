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
        {Phoenix, router: TestApp.Router},
        {Beam, poll_rate: 500},
        {Ecto, otp_app: :prom_ex, repos: [Test.Repo]}
      ]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
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
