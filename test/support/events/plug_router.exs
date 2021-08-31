[
  %{
    event: [:testapp, :plug, :router, :stop],
    measurements: %{
      duration: 53_504_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users/:id", fn _ -> :ok end}
        },
        status: 200
      },
      route: "/users/1",
      router: TestApp.PlugRouter
    }
  },
  %{
    event: [:testapp, :plug, :router, :stop],
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
      router: TestApp.PlugRouter
    }
  },
  %{
    event: [:testapp, :plug, :router, :stop],
    measurements: %{
      duration: 53_504_000
    },
    metadata: %{
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users/:id", fn _ -> :ok end}
        },
        status: 200
      },
      route: "/users/1",
      router: TestApp.OtherRouter
    }
  },
  %{
    event: [:plug, :router_dispatch, :exception],
    measurements: %{
      duration: 10_000_000
    },
    metadata: %{
      kind: :exit,
      reason: nil,
      stacktrace: [],
      conn: %Plug.Conn{
        method: "GET",
        private: %{
          plug_route: {"/users/:id", fn _ -> :ok end}
        },
        status: nil
      },
      route: "/users/1",
      router: TestApp.PlugRouter
    }
  }
]
