defmodule PromEx.PlugTest do
  use ExUnit.Case, async: false
  use Plug.Test

  import ExUnit.CaptureLog

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
    System.put_env("GIT_AUTHOR", "Alex")
    Application.put_env(:prom_ex, Test.Repo, telemetry_prefix: [:test, :repo])

    []
  end

  describe "init/1" do
    test "should raise an error if no prom_ex_module is provided" do
      assert_raise KeyError, ~r/^key :prom_ex_module not found.*/, fn ->
        PromEx.Plug.init([])
      end
    end

    test "should use the default path is one is not provided" do
      assert %{metrics_path: "/metrics"} = PromEx.Plug.init(prom_ex_module: Test.PromEx)
    end

    test "should return a map of all the settings if all are provided" do
      assert %{metrics_path: "/another/path", prom_ex_module: Test.PromEx} =
               PromEx.Plug.init(prom_ex_module: Test.PromEx, path: "/another/path")
    end
  end

  describe "call/2" do
    setup [:set_up_app_env, :setup_prom_ex_module]

    @tag :capture_log
    test "should return a 503 if the metrics supervisor is not accessible" do
      stop_supervised(DefaultPromExSetUp)

      opts = PromEx.Plug.init(prom_ex_module: DefaultPromExSetUp)
      conn = conn(:get, "/metrics")
      response = PromEx.Plug.call(conn, opts)

      assert response.status == 503
      assert response.resp_body == "Service Unavailable"

      assert capture_log(fn ->
               PromEx.Plug.call(conn, opts)
             end) =~ "Attempted to fetch metrics from Elixir.PromEx.PlugTest.DefaultPromExSetUp"
    end

    test "should return the metrics if the supervisor is running at the default path" do
      opts = PromEx.Plug.init(prom_ex_module: DefaultPromExSetUp)
      conn = conn(:get, "/metrics")
      response = PromEx.Plug.call(conn, opts)

      assert response.status == 200
      assert response.resp_body =~ "prom_ex_application_primary_info"
      assert response.resp_body =~ "395459c"
      assert response.resp_body =~ "Alex"
    end

    test "should return the metrics if the supervisor is running at a configured path" do
      opts = PromEx.Plug.init(prom_ex_module: DefaultPromExSetUp, path: "/some/path")
      conn = conn(:get, "/some/path")
      response = PromEx.Plug.call(conn, opts)

      assert response.status == 200
      assert response.resp_body =~ "prom_ex_application_primary_info"
      assert response.resp_body =~ "395459c"
      assert response.resp_body =~ "Alex"
    end

    test "should not alter the conn struct if the path does not equal the init opts" do
      opts = PromEx.Plug.init(prom_ex_module: DefaultPromExSetUp)
      conn = conn(:get, "/users")
      response = PromEx.Plug.call(conn, opts)

      assert response == conn
    end
  end

  def set_up_app_env(context) do
    Application.put_env(:prom_ex, DefaultPromExSetUp, metrics_server: :disabled)

    context
  end

  def setup_prom_ex_module(context) do
    # Starting PromEx module and sleeping for a short while to give the applications plugin
    # enough time to populate some metrics
    start_supervised(DefaultPromExSetUp)
    Process.sleep(500)

    context
  end
end
