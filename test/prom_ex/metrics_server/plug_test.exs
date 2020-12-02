defmodule PromEx.MetricsServer.PlugTest do
  use ExUnit.Case, async: true
  use Plug.Test

  alias Plug.Conn
  alias PromEx.MetricsServer

  describe "init/1" do
    test "should separate the auth strategy from the remainder of the opts" do
      opts = %{
        path: "/metrics",
        prom_ex_module: TestModule,
        auth_strategy: :none
      }

      assert {:none, %{path: "/metrics", prom_ex_module: TestModule}} = MetricsServer.Plug.init(opts)
    end
  end

  describe "call/2" do
    test "should give a 404 if the request route does not match the configured route" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: TestModule,
          auth_strategy: :none
        })

      conn = conn(:get, "/bad-path")

      assert %Conn{status: 404} = MetricsServer.Plug.call(conn, opts)
    end

    test "should return the metrics for a PromEx instance if no auth strategy is configured" do
    end

    test "should return the metrics for a PromEx instance if the bearer token is configured properly" do
    end

    test "should return the metrics for a PromEx instance if the basic token is configured properly" do
    end

    test "should return a 401 if the request has an invalid bearer token" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: TestModule,
          auth_strategy: :bearer,
          auth_token: "abcd=="
        })

      conn =
        :get
        |> conn("/metrics")
        |> put_req_header("authorization", "Bearer bad_token")

      assert %Conn{status: 401} = MetricsServer.Plug.call(conn, opts)
    end

    test "should return a 401 if the request has an invalid basic token" do
      opts =
        MetricsServer.Plug.init(%{
          path: "/metrics",
          prom_ex_module: TestModule,
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
end
