defmodule PromEx.MetricsServer.PlugTest do
  use ExUnit.Case, async: false
  use Plug.Test

  import ExUnit.CaptureLog

  alias Plug.Conn
  alias PromEx.MetricsServer

  defmodule DefaultPromExSetUp do
    use PromEx, otp_app: :prom_ex

    alias PromEx.Plugins.Application

    @impl true
    def plugins do
      [{Application, otp_app: :prom_ex}]
    end

    @impl true
    def dashboards do
      [{:prom_ex, "application.json"}]
    end
  end

  setup_all do
    System.put_env("GIT_SHA", "395459c")
    Application.put_env(:prom_ex, Test.Repo, telemetry_prefix: [:test, :repo])

    []
  end

  describe "init/1" do
    test "should separate the auth strategy from the remainder of the opts" do
      opts = %{
        path: "/metrics",
        prom_ex_module: DefaultPromExSetUp,
        auth_strategy: :none
      }

      assert {:none, %{path: "/metrics", prom_ex_module: DefaultPromExSetUp}} = MetricsServer.Plug.init(opts)
    end
  end

  describe "Basic auth" do
    setup [:setup_basic_app_env, :setup_prom_ex_module]

    test "should return the metrics for a PromEx instance if the basic token is configured properly" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :basic,
          auth_user: "root",
          auth_password: "toor"
        })

      auth_header = Base.encode64("root:toor")

      conn =
        :get
        |> conn("/metrics")
        |> put_req_header("authorization", "Basic #{auth_header}")

      response = MetricsServer.Plug.call(conn, opts)

      assert response.status == 200
      assert response.resp_body =~ "prom_ex_application_primary_info"
      assert response.resp_body =~ "395459c"
    end

    test "should return a 401 if the request has an invalid basic token" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :basic,
          auth_user: "root",
          auth_password: "toor"
        })

      auth_header = Base.encode64("admin:bad_pass")

      conn =
        :get
        |> conn("/metrics")
        |> put_req_header("authorization", "Basic #{auth_header}")

      assert %Conn{status: 401} = MetricsServer.Plug.call(conn, opts)
    end
  end

  describe "Bearer auth" do
    setup [:setup_bearer_app_env, :setup_prom_ex_module]

    test "should return the metrics for a PromEx instance if the bearer token is configured properly" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :bearer,
          auth_token: "abcd"
        })

      conn =
        :get
        |> conn("/metrics")
        |> put_req_header("authorization", "Bearer abcd")

      response = MetricsServer.Plug.call(conn, opts)

      assert response.status == 200
      assert response.resp_body =~ "prom_ex_application_primary_info"
      assert response.resp_body =~ "395459c"
    end

    test "should return a 401 if the request has an invalid bearer token" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :bearer,
          auth_token: "abcd=="
        })

      conn =
        :get
        |> conn("/metrics")
        |> put_req_header("authorization", "Bearer bad_token")

      assert %Conn{status: 401} = MetricsServer.Plug.call(conn, opts)
    end
  end

  describe "call/2" do
    setup [:setup_none_app_env, :setup_prom_ex_module]

    test "should return the metrics for a PromEx instance if no auth strategy is configured" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :none
        })

      conn = conn(:get, "/metrics")
      response = MetricsServer.Plug.call(conn, opts)

      assert response.status == 200
      assert response.resp_body =~ "prom_ex_application_primary_info"
      assert response.resp_body =~ "395459c"
    end

    test "should give a 404 if the request route does not match the configured route" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :none
        })

      conn = conn(:get, "/bad-path")

      assert %Conn{status: 404} = MetricsServer.Plug.call(conn, opts)
    end

    test "should return a 503 and emit a logger warning if the PromEx server is not available" do
      stop_supervised(DefaultPromExSetUp)

      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: DefaultPromExSetUp,
          auth_strategy: :none
        })

      conn = conn(:get, "/metrics")

      assert %Conn{status: 503} = MetricsServer.Plug.call(conn, opts)

      assert capture_log(fn ->
               MetricsServer.Plug.call(conn, opts)
             end) =~ "Attempted to fetch metrics from Elixir.PromEx.MetricsServer.PlugTest.DefaultPromExSetUp"
    end
  end

  def setup_basic_app_env(context) do
    set_up_app_env(port: 4422, auth_strategy: :basic, auth_user: "root", auth_password: "toor")

    context
  end

  def setup_bearer_app_env(context) do
    set_up_app_env(port: 4422, auth_strategy: :bearer, auth_token: "abcd")

    context
  end

  def setup_none_app_env(context) do
    set_up_app_env(port: 4422, auth_strategy: :none)

    context
  end

  def set_up_app_env(opts) do
    Application.put_env(:prom_ex, DefaultPromExSetUp, metrics_server: opts)
  end

  def setup_prom_ex_module(context) do
    # Starting PromEx module and sleeping for a short while to give the applications plugin
    # enough time to populate some metrics
    start_supervised(DefaultPromExSetUp)
    Process.sleep(500)

    context
  end
end
