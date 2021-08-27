[
  %{
    event: [:plug, :router_dispatch, :stop],
    measurements: %{
      duration: 53_504_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users", fn _ -> :ok end}
        },
        status: 200
      },
      route: "/users",
      router: TestApp.Router
    }
  },
  %{
    event: [:plug, :router_dispatch, :stop],
    measurements: %{
      duration: 5_000_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/metrics", fn _ -> :ok end}
        },
        status: 200
      },
      route: "/metrics",
      router: TestApp.Router
    }
  },
  %{
    event: [:plug, :router_dispatch, :stop],
    measurements: %{
      duration: 53_504_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users", fn _ -> :ok end}
        },
        status: 200
      },
      route: "/users",
      router: TestApp.OtherRouter
    }
  },
  %{
    event: [:plug, :router_dispatch, :exception],
    measurements: %{
      duration: 10_000_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users", fn _ -> :ok end}
        },
        status: nil
      },
      route: "/users",
      router: TestApp.Router
    }
  }
]
