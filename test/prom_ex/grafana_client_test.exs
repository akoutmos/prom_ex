defmodule PromEx.GrafanaClientTest do
  use ExUnit.Case, async: false

  alias PromEx.GrafanaClient

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    @impl true
    def plugins do
      []
    end

    @impl true
    def dashboards do
      []
    end
  end

  @moduletag :capture_log

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "allows for custom annotations being created", %{bypass: bypass} do
    response_payload = """
    {
      "message":"Annotation added",
      "id": 1
    }
    """

    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        upload_dashboards_on_start: false,
        annotate_app_lifecycle: true
      ]
    )

    Bypass.expect(bypass, "POST", "/api/annotations", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn, [])

      details = PromEx.JSON.decode!(body)
      assert details["time"] == 1_640_995_200_000
      assert details["tags"] == ["some", "tags"]
      assert details["text"] == "message"
      assert %{} == Map.drop(details, ["time", "tags", "text"])

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    conn = GrafanaClient.build_conn(DefaultPromExSetUp)

    assert {:ok, _} = GrafanaClient.create_annotation(conn, ["some", "tags"], "message", time: ~U[2022-01-01 00:00:00Z])
  end

  test "custom annotations handle key casing", %{bypass: bypass} do
    response_payload = """
    {
      "message":"Annotation added",
      "id": 1
    }
    """

    Application.put_env(:prom_ex, DefaultPromExSetUp,
      grafana: [
        host: endpoint_url(bypass.port),
        auth_token: "random_token",
        folder_name: "Web App Dashboards",
        upload_dashboards_on_start: false,
        annotate_app_lifecycle: true
      ]
    )

    Bypass.expect(bypass, "POST", "/api/annotations", fn conn ->
      {:ok, body, conn} = Plug.Conn.read_body(conn, [])

      details = PromEx.JSON.decode!(body)
      assert details["dashboardId"] == 1
      assert details["panelId"] == 2
      assert details["time"] == 1_640_995_200_000
      assert details["timeEnd"] == 1_641_081_600_000
      assert details["tags"] == ["some", "tags"]
      assert details["text"] == "message"

      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    conn = GrafanaClient.build_conn(DefaultPromExSetUp)

    assert {:ok, _} =
             GrafanaClient.create_annotation(conn, ["some", "tags"], "message",
               time: ~U[2022-01-01 00:00:00Z],
               time_end: ~U[2022-01-02 00:00:00Z],
               dashboard_id: 1,
               panel_id: 2
             )
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"
end
