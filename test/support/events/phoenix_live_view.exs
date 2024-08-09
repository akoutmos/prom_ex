[
  %{
    event: [:phoenix, :live_view, :handle_event, :exception],
    measurements: %{duration: 1_726_645},
    metadata: %{
      event: "suggest",
      kind: :error,
      params: %{"_target" => ["q"], "q" => "a"},
      reason: :badarith,
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          __changed__: %{},
          flash: %{},
          live_action: :index,
          query: "",
          results: %{}
        },
        endpoint: WebAppWeb.Endpoint,
        fingerprints:
          {34_061_566_683_452_391_960_580_918_577_869_205_053,
           %{2 => {205_703_469_609_921_369_150_412_838_263_460_442_328, %{}}}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FsLZedbBRuAP2AGZ",
        parent_pid: nil,
        private: %{
          __changed__: %{},
          lifecycle: %{
            __struct__: Phoenix.LiveView.Lifecycle,
            handle_event: [],
            handle_info: [],
            handle_params: [],
            mount: []
          },
          root_view: WebAppWeb.PageLive
        },
        redirected: nil,
        router: WebAppWeb.Router,
        view: WebAppWeb.PageLive
      },
      stacktrace: [
        {WebAppWeb.PageLive, :handle_event, 3, [file: ~c"lib/web_app_web/live/page_live.ex", line: 24]},
        {Phoenix.LiveView.Channel, :"-view_handle_event/3-fun-0-", 3,
         [file: ~c"lib/phoenix_live_view/channel.ex", line: 349]},
        {:telemetry, :span, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Phoenix.LiveView.Channel, :handle_info, 2, [file: ~c"lib/phoenix_live_view/channel.ex", line: 206]},
        {:gen_server, :try_dispatch, 4, [file: ~c"gen_server.erl", line: 695]},
        {:gen_server, :handle_msg, 6, [file: ~c"gen_server.erl", line: 771]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      telemetry_span_context: :erlang.make_ref()
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :exception],
    measurements: %{duration: 20168},
    metadata: %{
      kind: :error,
      params: %{},
      reason: :badarith,
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{__changed__: %{}, flash: %{}, live_action: :index},
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FsLYeH2SC6QLjwIC",
        parent_pid: nil,
        private: %{
          __changed__: %{},
          assign_new: {%{}, []},
          connect_info: %{},
          connect_params: %{},
          lifecycle: %{
            __struct__: Phoenix.LiveView.Lifecycle,
            handle_event: [],
            handle_info: [],
            handle_params: [],
            mount: []
          },
          root_view: WebAppWeb.PageLive
        },
        redirected: nil,
        root_pid: nil,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: WebAppWeb.PageLive
      },
      stacktrace: [
        {WebAppWeb.PageLive, :mount, 3, [file: ~c"lib/web_app_web/live/page_live.ex", line: 14]},
        {Phoenix.LiveView.Utils, :"-maybe_call_live_view_mount!/4-fun-0-", 5,
         [file: ~c"lib/phoenix_live_view/utils.ex", line: 301]},
        {:telemetry, :span, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Phoenix.LiveView.Static, :call_mount_and_handle_params!, 5,
         [file: ~c"lib/phoenix_live_view/static.ex", line: 260]},
        {Phoenix.LiveView.Static, :render, 3, [file: ~c"lib/phoenix_live_view/static.ex", line: 110]},
        {Phoenix.LiveView.Controller, :live_render, 3, [file: ~c"lib/phoenix_live_view/controller.ex", line: 35]},
        {Phoenix.Router, :__call__, 2, [file: ~c"lib/phoenix/router.ex", line: 355]},
        {WebAppWeb.Endpoint, :plug_builder_call, 2, [file: ~c"lib/web_app_web/endpoint.ex", line: 1]},
        {WebAppWeb.Endpoint, :"call (overridable 3)", 2, [file: ~c"lib/plug/debugger.ex", line: 136]},
        {WebAppWeb.Endpoint, :call, 2, [file: ~c"lib/web_app_web/endpoint.ex", line: 1]},
        {Phoenix.Endpoint.Cowboy2Handler, :init, 4, [file: ~c"lib/phoenix/endpoint/cowboy2_handler.ex", line: 54]},
        {:cowboy_handler, :execute, 2,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl",
           line: 37
         ]},
        {:cowboy_stream_h, :execute, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl",
           line: 306
         ]},
        {:cowboy_stream_h, :request_process, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl",
           line: 295
         ]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      telemetry_span_context: :erlang.make_ref()
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :exception],
    measurements: %{duration: 8195},
    metadata: %{
      kind: :exit,
      params: %{},
      reason: {:noproc, {GenServer, :call, [BadGenServer, :test, 5000]}},
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{__changed__: %{}, flash: %{}, live_action: :index},
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FsLW2hz0t2WKyAIK",
        parent_pid: nil,
        private: %{
          __changed__: %{},
          assign_new: {%{}, []},
          connect_info: %{},
          connect_params: %{},
          lifecycle: %{
            __struct__: Phoenix.LiveView.Lifecycle,
            handle_event: [],
            handle_info: [],
            handle_params: [],
            mount: []
          },
          root_view: WebAppWeb.PageLive
        },
        redirected: nil,
        root_pid: nil,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: WebAppWeb.PageLive
      },
      stacktrace: [
        {GenServer, :call, 3, [file: ~c"lib/gen_server.ex", line: 1014]},
        {WebAppWeb.PageLive, :mount, 3, [file: ~c"lib/web_app_web/live/page_live.ex", line: 6]},
        {Phoenix.LiveView.Utils, :"-maybe_call_live_view_mount!/4-fun-0-", 5,
         [file: ~c"lib/phoenix_live_view/utils.ex", line: 301]},
        {:telemetry, :span, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl",
           line: 293
         ]},
        {Phoenix.LiveView.Static, :call_mount_and_handle_params!, 5,
         [file: ~c"lib/phoenix_live_view/static.ex", line: 260]},
        {Phoenix.LiveView.Static, :render, 3, [file: ~c"lib/phoenix_live_view/static.ex", line: 110]},
        {Phoenix.LiveView.Controller, :live_render, 3, [file: ~c"lib/phoenix_live_view/controller.ex", line: 35]},
        {Phoenix.Router, :__call__, 2, [file: ~c"lib/phoenix/router.ex", line: 355]},
        {WebAppWeb.Endpoint, :plug_builder_call, 2, [file: ~c"lib/web_app_web/endpoint.ex", line: 1]},
        {WebAppWeb.Endpoint, :"call (overridable 3)", 2, [file: ~c"lib/plug/debugger.ex", line: 136]},
        {WebAppWeb.Endpoint, :call, 2, [file: ~c"lib/web_app_web/endpoint.ex", line: 1]},
        {Phoenix.Endpoint.Cowboy2Handler, :init, 4, [file: ~c"lib/phoenix/endpoint/cowboy2_handler.ex", line: 54]},
        {:cowboy_handler, :execute, 2,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl",
           line: 37
         ]},
        {:cowboy_stream_h, :execute, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl",
           line: 306
         ]},
        {:cowboy_stream_h, :request_process, 3,
         [
           file: ~c"/home/apps/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl",
           line: 295
         ]},
        {:proc_lib, :init_p_do_apply, 3, [file: ~c"proc_lib.erl", line: 226]}
      ],
      telemetry_span_context: :erlang.make_ref()
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 518_187_700},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{},
      session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        changed: %{query: true, results: true},
        connected?: false,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPXFFUEch-EwdR",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          conn_session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
          connect_info: %{},
          connect_params: %{}
        },
        redirected: nil,
        root_pid: nil,
        root_view: WebAppWeb.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: WebAppWeb.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 9_852_700},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :home,
          live_module: Phoenix.LiveDashboard.PageLive
        },
        changed: %{},
        connected?: false,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPkj8v7PKWpGrx",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          conn_session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
          connect_info: %{},
          connect_params: %{}
        },
        redirected: {:live, :redirect, %{kind: :push, to: "/dashboard/nonode%40nohost/home"}},
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 1_570_300},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "home"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          environment: nil,
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:current, "Home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.HomePage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "home"},
            route: :home,
            tick: 0
          },
          system_info: %{
            banner: "Erlang/OTP 22 [erts-10.7.2.7] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [hipe]\n",
            dashboard_version: "0.2.10",
            elixir_version: "1.10.4",
            phoenix_version: "1.5.7",
            system_architecture: "x86_64-pc-linux-gnu"
          },
          system_limits: %{atoms: 1_048_576, ports: 1_048_576, processes: 262_144},
          system_usage: %{
            atoms: 26119,
            cpu_run_queue: 0,
            io: {4_250_008, 12_727_780},
            memory: %{
              atom: 793_529,
              binary: 2_445_888,
              code: 18_502_140,
              ets: 2_139_656,
              other: 20_187_275,
              process: 12_928_768,
              total: 56_997_256
            },
            ports: 33,
            processes: 447,
            total_run_queue: 0,
            uptime: 246_734
          }
        },
        changed: %{
          environment: true,
          menu: true,
          page: true,
          system_info: true,
          system_limits: true,
          system_usage: true
        },
        connected?: false,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPkk6f9aZxNmsR",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          conn_session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
          connect_info: %{},
          connect_params: %{},
          temporary_assigns: %{system_info: nil, system_usage: nil}
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 3_097_000},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "home"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          environment: nil,
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:current, "Home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.HomePage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "home"},
            route: :home,
            tick: 0
          },
          system_info: %{
            banner: "Erlang/OTP 22 [erts-10.7.2.7] [source] [64-bit] [smp:2:2] [ds:2:2:10] [async-threads:1] [hipe]\n",
            dashboard_version: "0.2.10",
            elixir_version: "1.10.4",
            phoenix_version: "1.5.7",
            system_architecture: "x86_64-pc-linux-gnu"
          },
          system_limits: %{atoms: 1_048_576, ports: 1_048_576, processes: 262_144},
          system_usage: %{
            atoms: 26236,
            cpu_run_queue: 1,
            io: {4_293_620, 13_202_331},
            memory: %{
              atom: 793_529,
              binary: 3_980_976,
              code: 18_649_543,
              ets: 2_756_560,
              other: 20_239_496,
              process: 13_375_752,
              total: 59_795_856
            },
            ports: 36,
            processes: 476,
            total_run_queue: 1,
            uptime: 248_128
          }
        },
        changed: %{
          environment: true,
          menu: true,
          page: true,
          system_info: true,
          system_limits: true,
          system_usage: true
        },
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPkk6f9aZxNmsR",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "PRwbAiBcODhaCjcUA0B1DjoyWxs6GToIvswkq5Pw43qFT4LgMh7hJWto",
            "_mounts" => 0
          },
          temporary_assigns: %{system_info: nil, system_usage: nil}
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 13_033_300},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "metrics"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          items: ["phoenix", "vm", "web_app"],
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:current, "Metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.MetricsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "metrics"},
            route: :metrics,
            tick: 0
          }
        },
        changed: %{items: true, menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPkvX4Kp4taW6h",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "PRwbAiBcODhaCjcUA0B1DjoyWxs6GToIvswkq5Pw43qFT4LgMh7hJWto",
            "_mounts" => 0
          }
        },
        redirected: {:live, :redirect, %{kind: :push, to: "/dashboard/nonode%40nohost/metrics?nav=phoenix"}},
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 2_126_300},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{
        "nav" => "phoenix",
        "node" => "nonode@nohost",
        "page" => "metrics"
      },
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          items: ["phoenix", "vm", "web_app"],
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:current, "Metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          metrics: nil,
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.MetricsPage,
            node: :nonode@nohost,
            params: %{
              "nav" => "phoenix",
              "node" => "nonode@nohost",
              "page" => "metrics"
            },
            route: :metrics,
            tick: 0
          }
        },
        changed: %{items: true, menu: true, metrics: true, page: true},
        connected?: false,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPk3e3qvrRIm-B",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          conn_session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
          connect_info: %{},
          connect_params: %{}
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 14_130_600},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{
        "nav" => "phoenix",
        "node" => "nonode@nohost",
        "page" => "metrics"
      },
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          items: ["phoenix", "vm", "web_app"],
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:current, "Metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          metrics: [
            {%{
               __struct__: Telemetry.Metrics.Summary,
               description: nil,
               event_name: [:phoenix, :endpoint, :stop],
               keep: nil,
               measurement: nil,
               name: [:phoenix, :endpoint, :stop, :duration],
               reporter_options: [],
               tag_values: nil,
               tags: [],
               unit: :millisecond
             }, 0},
            {%{
               __struct__: Telemetry.Metrics.Summary,
               description: nil,
               event_name: [:phoenix, :router_dispatch, :stop],
               keep: nil,
               measurement: nil,
               name: [:phoenix, :router_dispatch, :stop, :duration],
               reporter_options: [],
               tag_values: nil,
               tags: [:route],
               unit: :millisecond
             }, 1}
          ],
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.MetricsPage,
            node: :nonode@nohost,
            params: %{
              "nav" => "phoenix",
              "node" => "nonode@nohost",
              "page" => "metrics"
            },
            route: :metrics,
            tick: 0
          }
        },
        changed: %{items: true, menu: true, metrics: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPk3e3qvrRIm-B",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "Ii0KOQkrEj4cWjIAJiBsUEQ5FEcxPQ0QiBfPXBzqrctRqTU93cx4AsCw",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 4_767_700},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "request_logger"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:current, "Request Logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.RequestLoggerPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "request_logger"},
            route: :request_logger,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPk9T13trnrHAB",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "Ii0KOQkrEj4cWjIAJiBsUEQ5FEcxPQ0QiBfPXBzqrctRqTU93cx4AsCw",
            "_mounts" => 0
          }
        },
        redirected:
          {:live, :redirect,
           %{
             kind: :push,
             to: "/dashboard/nonode%40nohost/request_logger?stream=gQhG"
           }},
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 273_200},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{
        "node" => "nonode@nohost",
        "page" => "request_logger",
        "stream" => "gQhG"
      },
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          autoscroll_enabled: true,
          cookie_domain: nil,
          cookie_enabled: false,
          cookie_key: "request_logger",
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:current, "Request Logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          messages: [],
          messages_present: false,
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.RequestLoggerPage,
            node: :nonode@nohost,
            params: %{
              "node" => "nonode@nohost",
              "page" => "request_logger",
              "stream" => "gQhG"
            },
            route: :request_logger,
            tick: 0
          },
          param_key: "request_logger",
          stream: "gQhG"
        },
        changed: %{
          autoscroll_enabled: true,
          cookie_domain: true,
          cookie_enabled: true,
          cookie_key: true,
          menu: true,
          messages_present: true,
          page: true,
          param_key: true,
          stream: true
        },
        connected?: false,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlJUAuRYEo3DB",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          conn_session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"},
          connect_info: %{},
          connect_params: %{},
          temporary_assigns: %{messages: []}
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 438_100},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{
        "node" => "nonode@nohost",
        "page" => "request_logger",
        "stream" => "gQhG"
      },
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          autoscroll_enabled: true,
          cookie_domain: nil,
          cookie_enabled: false,
          cookie_key: "request_logger",
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:current, "Request Logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: false,
            timer: nil
          },
          messages: [],
          messages_present: false,
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.RequestLoggerPage,
            node: :nonode@nohost,
            params: %{
              "node" => "nonode@nohost",
              "page" => "request_logger",
              "stream" => "gQhG"
            },
            route: :request_logger,
            tick: 0
          },
          param_key: "request_logger",
          stream: "gQhG"
        },
        changed: %{
          autoscroll_enabled: true,
          cookie_domain: true,
          cookie_enabled: true,
          cookie_key: true,
          menu: true,
          messages_present: true,
          page: true,
          param_key: true,
          stream: true
        },
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlJUAuRYEo3DB",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          },
          temporary_assigns: %{messages: []}
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 445_000},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "applications"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:current, "Applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.ApplicationsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "applications"},
            route: :applications,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlNMVTE6g-nAC",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 226_400},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "processes"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:current, "Processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.ProcessesPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "processes"},
            route: :processes,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlQ5HjV4S3XDx",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 899_800},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "ports"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:current, "Ports"},
              {:enabled, "Sockets", "sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.PortsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "ports"},
            route: :ports,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlTvep1IqmnER",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 224_400},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "sockets"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:current, "Sockets"},
              {:enabled, "ETS", "ets"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.SocketsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "sockets"},
            route: :sockets,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlYvUfjqfu3Kx",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :mount, :stop],
    measurements: %{duration: 228_400},
    metadata: %{
      uri: "http://localhost:4000",
      params: %{"node" => "nonode@nohost", "page" => "ets"},
      session: %{
        "_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg",
        "pages" => [
          {"home", {Phoenix.LiveDashboard.HomePage, %{"env_keys" => nil}}},
          {"os_mon", {Phoenix.LiveDashboard.OSMonPage, %{}}},
          {"metrics",
           {Phoenix.LiveDashboard.MetricsPage,
            %{
              "metrics" => {WebAppWeb.Telemetry, :metrics},
              "metrics_history" => nil
            }}},
          {"request_logger",
           {Phoenix.LiveDashboard.RequestLoggerPage,
            %{
              "cookie_domain" => nil,
              "request_logger" => {"request_logger", "request_logger"}
            }}},
          {"applications", {Phoenix.LiveDashboard.ApplicationsPage, %{}}},
          {"processes", {Phoenix.LiveDashboard.ProcessesPage, %{}}},
          {"ports", {Phoenix.LiveDashboard.PortsPage, %{}}},
          {"sockets", {Phoenix.LiveDashboard.SocketsPage, %{}}},
          {"ets", {Phoenix.LiveDashboard.EtsPage, %{}}}
        ],
        "requirements" => [application: :os_mon]
      },
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:current, "ETS"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.EtsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "ets"},
            route: :ets,
            tick: 0
          }
        },
        changed: %{menu: true, page: true},
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints: {nil, %{}},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlbj_0GKg6nCi",
        parent_pid: nil,
        private: %{
          assign_new: {%{}, []},
          connect_info: %{
            session: %{"_csrf_token" => "KoliQihOn9FRWt9iwZlspNNg"}
          },
          connect_params: %{
            "_csrf_token" => "ER5cAws8UDojdyEBBjl6ICgjNAMYNAk4Zq0jZU8uMNgSQMCI_yXphzG_",
            "_mounts" => 0
          }
        },
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        transport_pid: nil,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  },
  %{
    event: [:phoenix, :live_view, :handle_event, :stop],
    measurements: %{duration: 44400},
    metadata: %{
      event: "select_refresh",
      params: %{"_target" => ["refresh"], "refresh" => "30"},
      socket: %{
        __struct__: Phoenix.LiveView.Socket,
        assigns: %{
          flash: %{},
          live_action: :page,
          live_module: Phoenix.LiveDashboard.PageLive,
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:current, "ETS"}
            ],
            nodes: [:nonode@nohost],
            refresh: 30,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          },
          page: %{
            __struct__: Phoenix.LiveDashboard.PageBuilder,
            info: nil,
            module: Phoenix.LiveDashboard.EtsPage,
            node: :nonode@nohost,
            params: %{"node" => "nonode@nohost", "page" => "ets"},
            route: :ets,
            tick: 0
          }
        },
        changed: %{
          menu: %{
            __struct__: Phoenix.LiveDashboard.PageLive,
            links: [
              {:enabled, "Home", "home"},
              {:disabled, "OS Data", "https://hexdocs.pm/phoenix_live_dashboard/os_mon.html"},
              {:enabled, "Metrics", "metrics"},
              {:enabled, "Request Logger", "request_logger"},
              {:enabled, "Applications", "applications"},
              {:enabled, "Processes", "processes"},
              {:enabled, "Ports", "ports"},
              {:enabled, "Sockets", "sockets"},
              {:current, "ETS"}
            ],
            nodes: [:nonode@nohost],
            refresh: 15,
            refresh_options: [
              {"1s", 1},
              {"2s", 2},
              {"5s", 5},
              {"15s", 15},
              {"30s", 30}
            ],
            refresher?: true,
            timer: nil
          }
        },
        connected?: true,
        endpoint: WebAppWeb.Endpoint,
        fingerprints:
          {227_320_755_574_966_542_928_855_689_574_751_129_292,
           %{
             0 => {77_296_526_119_445_402_596_027_652_037_673_309_434, %{}},
             2 => 160_877_180_433_664_204_857_386_761_564_767_392_078
           }},
        host_uri: %{
          __struct__: URI,
          authority: nil,
          fragment: nil,
          host: "localhost",
          path: nil,
          port: 4000,
          query: nil,
          scheme: "http",
          userinfo: nil
        },
        id: "phx-FmRPlbj_0GKg6nCi",
        parent_pid: nil,
        private: %{},
        redirected: nil,
        root_pid: nil,
        root_view: Phoenix.LiveDashboard.PageLive,
        router: WebAppWeb.Router,
        view: Phoenix.LiveDashboard.PageLive
      }
    }
  }
]
