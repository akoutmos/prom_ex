defmodule PromEx.LifecycleAnnotatorTest do
  use ExUnit.Case, async: false

  alias PromEx.LifecycleAnnotator

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
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  @moduletag :capture_log

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "should check for existing folders", %{bypass: bypass} do
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
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    {:ok, _} =
      start_supervised(
        {PromEx.GrafanaClient, [name: DefaultPromExSetUp.__grafana_client_name__()]},
        restart: :temporary
      )

    {:ok, pid} =
      start_supervised(
        {
          LifecycleAnnotator,
          [
            name: DefaultPromExSetUp.__lifecycle_annotator_name__(),
            prom_ex_module: DefaultPromExSetUp,
            otp_app: :prom_ex
          ]
        },
        restart: :temporary
      )

    # Ensure we get through the continue
    :sys.get_state(pid)

    # Ensure we get another post for the terminate callback
    Bypass.expect(bypass, "POST", "/api/annotations", fn conn ->
      Plug.Conn.resp(conn, 200, response_payload)
    end)

    GenServer.stop(DefaultPromExSetUp.__lifecycle_annotator_name__())

    wait_for_process(pid, 1_000)
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"

  defp wait_for_process(_pid, timeout) when timeout < 0 do
    flunk("LifecycleAnnotator failed to terminate")
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
