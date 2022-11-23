[
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 283_603_391},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45808},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 1,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UmRKY2tvT1N6eW9CZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgAbYpLpeQFiAAFRgA.V_Nt2i0dIFISiDdgc8FslE5YpFWFalR7OeV1o1kHABs",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UmRKY2tvT1N6eW9CbgYAH2KS6XkBYgABUYA.VLaD3ixn6D-1WUeGVOr_n0sGiaT1qT423DXvdBDmVik",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8RdJckoOSzyoB", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "d2NaHy1nLiAQQHlkFUZFSyYMNiIlIhsGAQlShJVKy8NTfu6zQnyCqHQu", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UmRKY2tvT1N6eW9CZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgAbYpLpeQFiAAFRgA.V_Nt2i0dIFISiDdgc8FslE5YpFWFalR7OeV1o1kHABs",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UmRKY2tvT1N6eW9CbgYAH2KS6XkBYgABUYA.VLaD3ixn6D-1WUeGVOr_n0sGiaT1qT423DXvdBDmVik",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8RdJckoOSzyoB", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8RdF9uyemks8AAAST"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 77014},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 50695},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 335_966_925},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "max-age=0",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45812},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 2,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UmhtY09wMWdNUW9RZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgAWZ5LpeQFiAAFRgA.0CAPt589KQBjKG1GrFuws9Ag2Ffhmbz9zxIYav8aclg",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UmhtY09wMWdNUW9RbgYAFmeS6XkBYgABUYA.f0c08x0Pta96OOHnub0gtIWcmSy1qcElTjizsFObz-M",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8RhmcOp1gMQoQ", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "max-age=0"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "dF0OPzweNVsvCQVeOWxHAxokHykgGR4iBo8sy3M0Fq2nJ_42mFPHtsTQ", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UmhtY09wMWdNUW9RZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgAWZ5LpeQFiAAFRgA.0CAPt589KQBjKG1GrFuws9Ag2Ffhmbz9zxIYav8aclg",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UmhtY09wMWdNUW9RbgYAFmeS6XkBYgABUYA.f0c08x0Pta96OOHnub0gtIWcmSy1qcElTjizsFObz-M",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8RhmcOp1gMQoQ", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8RhmQ5alUYDEAAAmQ"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 69811},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 47650},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 336_224_658},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "max-age=0",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45812},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 5,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UnNhSVI3dlgzQUlLZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgBrcpLpeQFiAAFRgA.3bQWu72I3UBGDq5t-2o8y89xEAXmEM_Azfms0zXCe_Y",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UnNhSVI3dlgzQUlLbgYAa3KS6XkBYgABUYA.pgckkuJDFRjuWhm_BuwViHStfJgZQ7jcoBECzF6CsLc",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8RsaIR7vX3AIK", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "max-age=0"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "aQpMFXYbLB4RSXlmOksLdyAaeRYtDQMy_8zY36Tux1NVIxxFWx6wygIA", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UnNhSVI3dlgzQUlLZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgBrcpLpeQFiAAFRgA.3bQWu72I3UBGDq5t-2o8y89xEAXmEM_Azfms0zXCe_Y",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UnNhSVI3dlgzQUlLbgYAa3KS6XkBYgABUYA.pgckkuJDFRjuWhm_BuwViHStfJgZQ7jcoBECzF6CsLc",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8RsaIR7vX3AIK", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8RsZ5YURy19wAAAGK"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 79910},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 10_729_941},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 5,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body:
          "<!DOCTYPE html>\n<html>\n<head>\n    <meta charset=\"utf-8\">\n    <title>ArithmeticError at GET /</title>\n    <meta name=\"viewport\" content=\"width=device-width\">\n    <style>/*! normalize.css v4.2.0 | MIT License | github.com/necolas/normalize.css */html{font-family:sans-serif;line-height:1.15;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}article,aside,details,figcaption,figure,footer,header,main,menu,nav,section{display:block}audio,canvas,progress,video{display:inline-block}audio:not([controls]){display:none;height:0}progress{vertical-align:baseline}template,[hidden]{display:none}a{background-color:transparent;-webkit-text-decoration-skip:objects}a:active,a:hover{outline-width:0}abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}b,strong{font-weight:inherit}b,strong{font-weight:bolder}dfn{font-style:italic}h1{font-size:2em;margin:0.67em 0}mark{background-color:#ff0;color:#000}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-0.25em}sup{top:-0.5em}img{border-style:none}svg:not(:root){overflow:hidden}code,kbd,pre,samp{font-family:monospace, monospace;font-size:1em}figure{margin:1em 40px}hr{box-sizing:content-box;height:0;overflow:visible}button,input,optgroup,select,textarea{font:inherit;margin:0}optgroup{font-weight:bold}button,input{overflow:visible}button,select{text-transform:none}button,html [type=\"button\"],[type=\"reset\"],[type=\"submit\"]{-webkit-appearance:button}button::-moz-focus-inner,[type=\"button\"]::-moz-focus-inner,[type=\"reset\"]::-moz-focus-inner,[type=\"submit\"]::-moz-focus-inner{border-style:none;padding:0}button:-moz-focusring,[type=\"button\"]:-moz-focusring,[type=\"reset\"]:-moz-focusring,[type=\"submit\"]:-moz-focusring{outline:1px dotted ButtonText}fieldset{border:1px solid #c0c0c0;margin:0 2px;padding:0.35em 0.625em 0.75em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}textarea{overflow:auto}[type=\"checkbox\"],[type=\"radio\"]{box-sizing:border-box;padding:0}[type=\"number\"]::-webkit-inner-spin-button,[type=\"number\"]::-webkit-outer-spin-button{height:auto}[type=\"search\"]{-webkit-appearance:textfield;outline-offset:-2px}[type=\"search\"]::-webkit-search-cancel-button,[type=\"search\"]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-input-placeholder{color:inherit;opacity:0.54}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}</style>\n    <style>\n    html, body, td, input {\n        font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", \"Roboto\", \"Oxygen\", \"Ubuntu\", \"Cantarell\", \"Fira Sans\", \"Droid Sans\", \"Helvetica Neue\", sans-serif;\n    }\n\n    * {\n        box-sizing: border-box;\n    }\n\n    html {\n        font-size: 15px;\n        line-height: 1.6;\n        background: #fff;\n        color: #203040;\n    }\n\n    @media (max-width: 768px) {\n        html {\n             font-size: 14px;\n        }\n    }\n\n    @media (max-width: 480px) {\n        html {\n             font-size: 13px;\n        }\n    }\n\n    button:focus,\n    summary:focus {\n        outline: 0;\n    }\n\n    summary {\n        cursor: pointer;\n    }\n\n    pre {\n        font-family: menlo, consolas, monospace;\n        overflow: auto;\n        max-width: 100%;\n    }\n\n    .top-details {\n        padding: 48px;\n        background: #f9f9fa;\n    }\n\n    .top-details,\n    .conn-info {\n        padding: 48px;\n    }\n\n\n    @media (max-width: 768px) {\n        .top-details,\n        .conn-info {\n            padding: 32px;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .top-details,\n        .conn-info {\n            padding: 16px;\n        }\n    }\n\n    /*\n     * Exception logo\n     */\n\n    \n    .exception-logo {\n        position: absolute;\n        right: 48px;\n        top: 48px;\n        pointer-events: none;\n        width: 100%;\n    }\n\n    .exception-logo:before {\n        content: '';\n        display: block;\n        height: 64px;\n        width: 100%;\n        background-size: auto 100%;\n        background-image: url(\"data:image/png;base64,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\");\n        background-position: right 0;\n        background-repeat: no-repeat;\n        margin-bottom: 16px;\n    }\n\n    @media (max-width: 768px) {\n        .exception-logo {\n            position: static;\n        }\n\n        .exception-logo:before {\n            height: 32px;\n            background-position: left 0;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .exception-logo {\n            display: none;\n        }\n    }\n    \n\n    /*\n     * Exception info\n     */\n\n    /* Compensate for logo placement */\n    @media (min-width: 769px) {\n        .exception-info {\n            max-width: 90%;\n        }\n    }\n\n    .exception-info > .struct,\n    .exception-info > .title,\n    .exception-info > .detail {\n        margin: 0;\n        padding: 0;\n    }\n\n    .exception-info > .struct {\n        font-size: 1em;\n        font-weight: 700;\n        color: #EB532D;\n    }\n\n    .exception-info > .struct > small {\n        font-size: 1em;\n        color: #607080;\n        font-weight: 400;\n    }\n\n    .exception-info > .title {\n        font-size: 2.0736em;\n        line-height: 1.4;\n        font-weight: 300;\n        color: #EB532D;\n    }\n\n    @media (max-width: 768px) {\n        .exception-info > .title {\n            font-size: 1.7490062499999994em;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .exception-info > .title {\n            font-size: 1.4641000000000004em;\n        }\n    }\n\n    .exception-info > .detail {\n        margin-top: 1.3em;\n        white-space: pre-wrap;\n    }\n\n    /*\n     * Code explorer\n     */\n\n    .code-explorer {\n      margin: 32px 0 0 0;\n    }\n\n    @media (max-width: 768px) {\n        .code-explorer {\n            margin-top: 16px;\n        }\n    }\n\n    .code-explorer:after {\n        content: '';\n        display: table;\n        clear: both;\n        zoom: 1;\n    }\n\n    .code-explorer > .code-snippets {\n        float: left;\n        width: 45%;\n    }\n\n    .code-explorer > .stack-trace {\n        float: right;\n        width: 55%;\n        padding-left: 32px;\n    }\n\n    /* Collapse to single-column */\n    @media (max-width: 960px) {\n        .code-explorer > .code-snippets {\n            float: none;\n            width: auto;\n            margin-bottom: 16px;\n        }\n\n        .code-explorer > .stack-trace {\n            float: none;\n            width: auto;\n            padding-left: 0;\n        }\n    }\n\n    /*\n     * Frame info:\n     * Holds the code (code-block) and more\n     */\n\n    .frame-info {\n        background: white;\n        box-shadow:\n            0 1px 3px rgba(80, 100, 140, .1),\n            0 8px 15px rgba(80, 100, 140, .05);\n    }\n\n    .frame-info > .meta,\n    .frame-info > .file {\n        padding: 12px 16px;\n        white-space: no-wrap;\n        font-size: 0.8333333333333334em;\n    }\n\n    @media (max-width: 480px) {\n        .frame-info > .meta,\n        .frame-info > .file {\n            padding: 6px 16px;\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    .frame-info > .file > a {\n        text-decoration: none;\n        color: #203040;\n        font-weight: 700;\n    }\n\n    .frame-info > .code {\n        border-top: solid 1px #eee;\n        border-bottom: solid 1px #eee;\n        font-size: 0.8em;\n    }\n\n    /* Hiding */\n    .frame-info {\n        display: none;\n    }\n\n    .frame-info.-active {\n        display: block;\n    }\n\n    .frame-info > details.meta {\n        border-top: solid 1px #eee;\n        padding: 0;\n    }\n\n    .frame-info > details.meta > summary {\n        padding: 12px 16px;\n    }\n\n    .frame-info > details.meta > pre {\n        line-height: 16px;\n        padding: 6px 0 24px 30px;\n    }\n\n    .frame-info > details.meta > ol {\n        counter-reset: item;\n        padding: 6px 0 24px 46px;\n        list-style: none;\n    }\n\n    .frame-info > details.meta > ol > li {\n        counter-increment: item;\n    }\n\n    .frame-info > details.meta > ol > li:before {\n        content: counter(item) \". \";\n        color: #607080;\n    }\n\n    /*\n     * Frame details\n     */\n\n    .frame-mfa {\n        color: #607080;\n    }\n\n    .frame-mfa > .app {\n        color: #607080;\n    }\n\n    .frame-mfa > .docs {\n        color: #EB532D;\n        text-decoration: none;\n    }\n\n    .frame-mfa .docs:hover {\n        text-decoration: underline;\n    }\n\n    .frame-mfa > .right {\n        float: right;\n        padding-left: 5px;\n    }\n\n    .frame-mfa > .right:after {\n        content: '·';\n        margin-left: .2em;\n        padding-left: .2em;\n    }\n\n    .frame-mfa > .right:first-child:after {\n        content: '';\n    }\n\n    /*\n     * Code block:\n     * The `pre` that holds the code\n     */\n\n    .code-block {\n        margin: 0;\n        padding: 12px 0;\n        font-size: 0.8333333333333334em;\n        line-height: 1.4;\n        white-space: normal;\n    }\n\n    .code-block > .line {\n        white-space: pre;\n        display: block;\n        padding: 0 16px;\n    }\n\n    /* Line highlight */\n    .code-block > .line.-highlight {\n        background-color: #f0f4fa;\n        -webkit-animation: line-highlight 750ms linear;\n        animation: line-highlight 750ms linear;\n    }\n\n    @-webkit-keyframes line-highlight {\n        0% { background-color: #f0f4fa; }\n        25% { background-color: #ffe5e5; }\n        50% { background-color: #f0f4fa; }\n        75% { background-color: #ffe5e5; }\n    }\n\n    @keyframes line-highlight {\n        0% { background-color: #f0f4fa; }\n        25% { background-color: #ffe5e5; }\n        50% { background-color: #f0f4fa; }\n        75% { background-color: #ffe5e5; }\n    }\n\n    .code-block > .line > .ln {\n        color: #607080;\n        margin-right: 1.5em;\n        -webkit-user-select: none;\n        -moz-user-select: none;\n        -ms-user-select: none;\n        user-select: none;\n    }\n\n    .code-block > .line > .code {\n        font-family: menlo, consolas, monospace;\n    }\n\n    /*\n     * Empty code\n     */\n\n    .code-block-empty {\n        text-align: center;\n        color: #607080;\n        padding-top: 48px;\n        padding-bottom: 48px;\n    }\n\n    /*\n     * Stack trace heading\n     */\n\n    .stack-trace-heading {\n        padding-top: 8px;\n    }\n\n    .stack-trace-heading:after {\n        content: '';\n        display: block;\n        clear: both;\n        zoom: 1;\n        border-bottom: solid 1px #eee;\n        padding-top: 12px;\n        margin-bottom: 16px;\n    }\n\n    .stack-trace-heading > h3 {\n        display: none;\n    }\n\n    .stack-trace-heading > label {\n        display: block;\n        padding-left: 8px;\n        line-height: 1.9;\n        font-size: 0.8333333333333334em;\n        -webkit-user-select: none;\n        -moz-user-select: none;\n        -ms-user-select: none;\n        user-select: none;\n    }\n\n    .stack-trace-heading > label > input {\n        margin-right: .3em;\n    }\n\n    @media (max-width: 480px) {\n        .stack-trace-heading > label {\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    /*\n     * Stack trace\n     */\n\n    .stack-trace-list,\n    .stack-trace-list > li {\n        margin: 0;\n        padding: 0;\n        list-style-type: none;\n    }\n\n    .stack-trace-list > li > .stack-trace-item.-all {\n        display: none;\n    }\n\n    .stack-trace-list.-show-all > li > .stack-trace-item.-all {\n        display: block;\n    }\n\n    /*\n     * Stack trace item:\n     * The clickable line to inspect a stack trace\n     */\n\n    .stack-trace-item {\n        font-size: 0.8333333333333334em;\n        display: block;\n        width: 100%;\n        border: 0;\n        margin: 0;\n        padding: 4px 8px;\n        background: transparent;\n        cursor: pointer;\n        text-align: left;\n        overflow: hidden;\n        white-space: nowrap;\n    }\n\n    .stack-trace-item:hover,\n    .stack-trace-item:focus {\n        background-color: rgba(80, 100, 140, 0.05);\n    }\n\n    .stack-trace-item,\n    .stack-trace-item:active {\n        color: #203040;\n    }\n\n    .stack-trace-item:active {\n        background-color: rgba(80, 100, 140, 0.1);\n    }\n\n    .stack-trace-item.-active {\n        background-color: white;\n    }\n\n    /* Circle */\n    .stack-trace-item > .left:before {\n        content: '';\n        display: inline-block;\n        width: 8px;\n        height: 8px;\n        background: #a0b0c0;\n        border-radius: 50%;\n        margin-right: 8px;\n    }\n\n    .stack-trace-item.-app > .left:before {\n        background: #EB532D;\n        opacity: 1;\n    }\n\n    .stack-trace-item.-app > .left > .app {\n        display: none;\n    }\n\n    .stack-trace-item > .left {\n        float: left;\n        max-width: 55%;\n    }\n\n    .stack-trace-item > .info {\n        color: #607080;\n        float: right;\n        max-width: 45%;\n    }\n\n    .stack-trace-item > .left,\n    .stack-trace-item > .info {\n        white-space: nowrap;\n        overflow: hidden;\n        text-overflow: ellipsis;\n    }\n\n    .stack-trace-item > .left > .filename > .line {\n        color: #607080;\n    }\n\n    /* App name */\n    .stack-trace-item > .left > .app {\n        color: #607080;\n    }\n\n    .stack-trace-item > .left > .app:after {\n        content: '·';\n        margin: 0 .2em;\n    }\n\n    /*\n     * Code as a blockquote:\n     * Like `pre` but with wrapping\n     */\n\n    .code-quote {\n        font-family: menlo, consolas, monospace;\n        font-size: 0.8333333333333334em;\n        margin: 0;\n        overflow: auto;\n        max-width: 100%;\n        word-wrap: break-word;\n        white-space: normal;\n    }\n\n    .code.-padded {\n        padding: 0 16px 16px 16px;\n    }\n\n    .code i.red {\n        color: #CC0000;\n        font-style: normal;\n    }\n\n    .code i.green {\n        font-style: normal;\n    }\n\n    .banner {\n      padding: 24px 48px 24px 48px;\n      border-top: solid 1px #eee;\n    }\n\n    /*\n     * Conn info\n     */\n\n    .conn-info {\n        border-top: solid 1px #eee;\n    }\n\n    /*\n     * Conn details\n     */\n\n    .conn-details {\n    }\n\n    .conn-details + .conn-details {\n        margin-top: 16px;\n    }\n\n    .conn-details > summary {\n    }\n\n    .conn-details > dl {\n        display: block;\n        overflow: hidden;\n        margin: 0;\n        padding: 4px 0;\n        border-bottom: solid 1px #eee;\n        white-space: nowrap;\n        text-overflow: ellipsis;\n    }\n\n    .conn-details > dl:first-of-type {\n        margin-top: 16px;\n        border-top: solid 1px #eee;\n    }\n\n    /* Term */\n    .conn-details > dl > dt {\n        width: 20%;\n        float: left;\n        font-size: 0.8333333333333334em;\n        color: #607080;\n        overflow: hidden;\n        text-overflow: ellipsis;\n        position: relative;\n        top: -1px; /* Compensate for font metrics */\n    }\n\n    /* Definition */\n    .conn-details > dl > dd {\n        width: 80%;\n        float: left;\n    }\n\n    @media (max-width: 480px) {\n        .conn-details > dl > dt {\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    .action-form {\n        display: inline-block;\n        margin: 20px 10px 5px 0;\n    }\n\n    .action-button:hover {\n        background-color: #f9f9fa;\n        cursor: pointer;\n    }\n\n    .action-button {\n        background-color: white;\n        border: 1px solid #EB532D;\n        border-radius: 3px;\n        color: #EB532D;\n        padding: 0 20px;\n    }\n\n    .action-button:active {\n        background-color: inherit;\n        background-color: #f2f2f4;\n    }\n    </style>\n</head>\n<body>\n    <div class=\"top-details\">\n        \n        <aside class=\"exception-logo\"></aside>\n        \n\n        <header class=\"exception-info\">\n            \n            <h5 class=\"struct\">\n                ArithmeticError\n                <small>at GET</small>\n                <small class=\"path\">/</small>\n            </h5>\n            <h1 class=\"title\">bad argument in arithmetic expression</h1>\n            \n        </header>\n\n        \n\n    \n\n        <div class=\"code-explorer\">\n            <div class=\"code-snippets\">\n                \n                  <div class=\"frame-info\" data-index=\"0\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/live/page_live.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">9</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">10</span><span class=\"code\">      2 -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">11</span><span class=\"code\">        Process.sleep(500)</span></span>\n<span class=\"line \"><span class=\"ln\">12</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">13</span><span class=\"code\">      val -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">14</span><span class=\"code\">        Process.sleep(floor(1_000 / val))</span></span>\n<span class=\"line \"><span class=\"ln\">15</span><span class=\"code\">    end</span></span>\n<span class=\"line \"><span class=\"ln\">16</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">17</span><span class=\"code\">    {:ok, assign(socket, query: &quot;&quot;, results: %{})}</span></span>\n<span class=\"line \"><span class=\"ln\">18</span><span class=\"code\">  end</span></span>\n<span class=\"line \"><span class=\"ln\">19</span><span class=\"code\"></span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.PageLive.mount/3\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"1\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/utils.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">307</span><span class=\"code\">        [:phoenix, :live_view, :mount],</span></span>\n<span class=\"line \"><span class=\"ln\">308</span><span class=\"code\">        %{socket: socket, params: params, session: session},</span></span>\n<span class=\"line \"><span class=\"ln\">309</span><span class=\"code\">        fn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">310</span><span class=\"code\">          socket =</span></span>\n<span class=\"line \"><span class=\"ln\">311</span><span class=\"code\">            params</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">312</span><span class=\"code\">            |&gt; view.mount(session, socket)</span></span>\n<span class=\"line \"><span class=\"ln\">313</span><span class=\"code\">            |&gt; handle_mount_result!({:mount, 3, view})</span></span>\n<span class=\"line \"><span class=\"ln\">314</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">315</span><span class=\"code\">          {socket, %{socket: socket, params: params, session: session}}</span></span>\n<span class=\"line \"><span class=\"ln\">316</span><span class=\"code\">        end</span></span>\n<span class=\"line \"><span class=\"ln\">317</span><span class=\"code\">      )</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            anonymous fn/4 in Phoenix.LiveView.Utils.maybe_call_live_view_mount!/4\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"2\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">267</span><span class=\"code\">span(EventPrefix, StartMetadata, SpanFunction) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">268</span><span class=\"code\">    StartTime = erlang:monotonic_time(),</span></span>\n<span class=\"line \"><span class=\"ln\">269</span><span class=\"code\">    DefaultCtx = erlang:make_ref(),</span></span>\n<span class=\"line \"><span class=\"ln\">270</span><span class=\"code\">    execute(EventPrefix ++ [start], \#{system_time =&gt; erlang:system_time()}, merge_ctx(StartMetadata, DefaultCtx)),</span></span>\n<span class=\"line \"><span class=\"ln\">271</span><span class=\"code\"></span></span>\n<span class=\"line -highlight\"><span class=\"ln\">272</span><span class=\"code\">    try {_, \#{}} = SpanFunction() of</span></span>\n<span class=\"line \"><span class=\"ln\">273</span><span class=\"code\">      {Result, StopMetadata} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">274</span><span class=\"code\">          execute(EventPrefix ++ [stop], \#{duration =&gt; erlang:monotonic_time() - StartTime}, merge_ctx(StopMetadata, DefaultCtx)),</span></span>\n<span class=\"line \"><span class=\"ln\">275</span><span class=\"code\">          Result</span></span>\n<span class=\"line \"><span class=\"ln\">276</span><span class=\"code\">    catch</span></span>\n<span class=\"line \"><span class=\"ln\">277</span><span class=\"code\">        ?WITH_STACKTRACE(Class, Reason, Stacktrace)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :telemetry.span/3\n                            \n                            \n                                <span class=\"app right\">telemetry</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"3\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/static.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">297</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">298</span><span class=\"code\">  defp call_mount_and_handle_params!(socket, view, session, params, uri) do</span></span>\n<span class=\"line \"><span class=\"ln\">299</span><span class=\"code\">    mount_params = if socket.router, do: params, else: :not_mounted_at_router</span></span>\n<span class=\"line \"><span class=\"ln\">300</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">301</span><span class=\"code\">    socket</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">302</span><span class=\"code\">    |&gt; Utils.maybe_call_live_view_mount!(view, mount_params, session)</span></span>\n<span class=\"line \"><span class=\"ln\">303</span><span class=\"code\">    |&gt; mount_handle_params(view, params, uri)</span></span>\n<span class=\"line \"><span class=\"ln\">304</span><span class=\"code\">    |&gt; case do</span></span>\n<span class=\"line \"><span class=\"ln\">305</span><span class=\"code\">      {:noreply, %Socket{redirected: {:live, _, _}} = socket} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">306</span><span class=\"code\">        {:stop, socket}</span></span>\n<span class=\"line \"><span class=\"ln\">307</span><span class=\"code\"></span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Static.call_mount_and_handle_params!/5\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"4\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/static.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">122</span><span class=\"code\">        action,</span></span>\n<span class=\"line \"><span class=\"ln\">123</span><span class=\"code\">        flash,</span></span>\n<span class=\"line \"><span class=\"ln\">124</span><span class=\"code\">        host_uri</span></span>\n<span class=\"line \"><span class=\"ln\">125</span><span class=\"code\">      )</span></span>\n<span class=\"line \"><span class=\"ln\">126</span><span class=\"code\"></span></span>\n<span class=\"line -highlight\"><span class=\"ln\">127</span><span class=\"code\">    case call_mount_and_handle_params!(socket, view, mount_session, conn.params, request_url) do</span></span>\n<span class=\"line \"><span class=\"ln\">128</span><span class=\"code\">      {:ok, socket} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">129</span><span class=\"code\">        data_attrs = [</span></span>\n<span class=\"line \"><span class=\"ln\">130</span><span class=\"code\">          phx_view: config.name,</span></span>\n<span class=\"line \"><span class=\"ln\">131</span><span class=\"code\">          phx_session: sign_root_session(socket, router, view, to_sign_session),</span></span>\n<span class=\"line \"><span class=\"ln\">132</span><span class=\"code\">          phx_static: sign_static_token(socket)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Static.render/3\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"5\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/controller.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">30</span><span class=\"code\">        end</span></span>\n<span class=\"line \"><span class=\"ln\">31</span><span class=\"code\">      end</span></span>\n<span class=\"line \"><span class=\"ln\">32</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">33</span><span class=\"code\">  &quot;&quot;&quot;</span></span>\n<span class=\"line \"><span class=\"ln\">34</span><span class=\"code\">  def live_render(%Plug.Conn{} = conn, view, opts \\\\ []) do</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">35</span><span class=\"code\">    case LiveView.Static.render(conn, view, opts) do</span></span>\n<span class=\"line \"><span class=\"ln\">36</span><span class=\"code\">      {:ok, content, socket_assigns} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">37</span><span class=\"code\">        conn</span></span>\n<span class=\"line \"><span class=\"ln\">38</span><span class=\"code\">        |&gt; Phoenix.Controller.put_view(LiveView.Static)</span></span>\n<span class=\"line \"><span class=\"ln\">39</span><span class=\"code\">        |&gt; LiveView.Plug.put_cache_headers()</span></span>\n<span class=\"line \"><span class=\"ln\">40</span><span class=\"code\">        |&gt; Phoenix.Controller.render(</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Controller.live_render/3\n                            \n                                <a class=\"docs right\" href=\"https://hexdocs.pm/phoenix_live_view/0.14.8/Phoenix.LiveView.Controller.html#live_render/3\">docs</a>\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"6\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix/router.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">347</span><span class=\"code\">    case pipeline.(conn) do</span></span>\n<span class=\"line \"><span class=\"ln\">348</span><span class=\"code\">      %Plug.Conn{halted: true} = halted_conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">349</span><span class=\"code\">        halted_conn</span></span>\n<span class=\"line \"><span class=\"ln\">350</span><span class=\"code\">      %Plug.Conn{} = piped_conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">351</span><span class=\"code\">        try do</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">352</span><span class=\"code\">          plug.call(piped_conn, plug.init(opts))</span></span>\n<span class=\"line \"><span class=\"ln\">353</span><span class=\"code\">        else</span></span>\n<span class=\"line \"><span class=\"ln\">354</span><span class=\"code\">          conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">355</span><span class=\"code\">            duration = System.monotonic_time() - start</span></span>\n<span class=\"line \"><span class=\"ln\">356</span><span class=\"code\">            metadata = %{metadata | conn: conn}</span></span>\n<span class=\"line \"><span class=\"ln\">357</span><span class=\"code\">            :telemetry.execute([:phoenix, :router_dispatch, :stop], %{duration: duration}, metadata)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.Router.__call__/2\n                            \n                            \n                                <span class=\"app right\">phoenix</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"7\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/endpoint.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line -highlight\"><span class=\"ln\">1</span><span class=\"code\">defmodule WebAppWeb.Endpoint do</span></span>\n<span class=\"line \"><span class=\"ln\">2</span><span class=\"code\">  use Phoenix.Endpoint, otp_app: :web_app</span></span>\n<span class=\"line \"><span class=\"ln\">3</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">4</span><span class=\"code\">  # The session will be stored in the cookie and signed,</span></span>\n<span class=\"line \"><span class=\"ln\">5</span><span class=\"code\">  # this means its contents can be read but not tampered with.</span></span>\n<span class=\"line \"><span class=\"ln\">6</span><span class=\"code\">  # Set :encryption_salt if you would also like to encrypt it.</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.plug_builder_call/2\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"8\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/plug/debugger.ex</a>\n                    </div>\n\n                    \n                    <div class=\"code code-block-empty\">No code available.</div>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.&quot;call (overridable 3)&quot;/2\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"9\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/endpoint.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line -highlight\"><span class=\"ln\">1</span><span class=\"code\">defmodule WebAppWeb.Endpoint do</span></span>\n<span class=\"line \"><span class=\"ln\">2</span><span class=\"code\">  use Phoenix.Endpoint, otp_app: :web_app</span></span>\n<span class=\"line \"><span class=\"ln\">3</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">4</span><span class=\"code\">  # The session will be stored in the cookie and signed,</span></span>\n<span class=\"line \"><span class=\"ln\">5</span><span class=\"code\">  # this means its contents can be read but not tampered with.</span></span>\n<span class=\"line \"><span class=\"ln\">6</span><span class=\"code\">  # Set :encryption_salt if you would also like to encrypt it.</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.call/2\n                            \n                                <a class=\"docs right\" href=\"https://hexdocs.pm/web_app/0.1.0/WebAppWeb.Endpoint.html#call/2\">docs</a>\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"10\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix/endpoint/cowboy2_handler.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">60</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">61</span><span class=\"code\">        {:plug, conn, handler, opts} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">62</span><span class=\"code\">          %{adapter: {@connection, req}} =</span></span>\n<span class=\"line \"><span class=\"ln\">63</span><span class=\"code\">            conn =</span></span>\n<span class=\"line \"><span class=\"ln\">64</span><span class=\"code\">              conn</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">65</span><span class=\"code\">              |&gt; handler.call(opts)</span></span>\n<span class=\"line \"><span class=\"ln\">66</span><span class=\"code\">              |&gt; maybe_send(handler)</span></span>\n<span class=\"line \"><span class=\"ln\">67</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">68</span><span class=\"code\">          :telemetry.execute(</span></span>\n<span class=\"line \"><span class=\"ln\">69</span><span class=\"code\">            [:plug_adapter, :call, :stop],</span></span>\n<span class=\"line \"><span class=\"ln\">70</span><span class=\"code\">            %{duration: System.monotonic_time() - start},</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.Endpoint.Cowboy2Handler.init/4\n                            \n                            \n                                <span class=\"app right\">phoenix</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"11\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">32</span><span class=\"code\">-optional_callbacks([terminate/3]).</span></span>\n<span class=\"line \"><span class=\"ln\">33</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">34</span><span class=\"code\">-spec execute(Req, Env) -&gt; {ok, Req, Env}</span></span>\n<span class=\"line \"><span class=\"ln\">35</span><span class=\"code\">\twhen Req::cowboy_req:req(), Env::cowboy_middleware:env().</span></span>\n<span class=\"line \"><span class=\"ln\">36</span><span class=\"code\">execute(Req, Env=\#{handler := Handler, handler_opts := HandlerOpts}) -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">37</span><span class=\"code\">\ttry Handler:init(Req, HandlerOpts) of</span></span>\n<span class=\"line \"><span class=\"ln\">38</span><span class=\"code\">\t\t{ok, Req2, State} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">39</span><span class=\"code\">\t\t\tResult = terminate(normal, Req2, State, Handler),</span></span>\n<span class=\"line \"><span class=\"ln\">40</span><span class=\"code\">\t\t\t{ok, Req2, Env\#{result =&gt; Result}};</span></span>\n<span class=\"line \"><span class=\"ln\">41</span><span class=\"code\">\t\t{Mod, Req2, State} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">42</span><span class=\"code\">\t\t\tMod:upgrade(Req2, Env, Handler, State);</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_handler.execute/2\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"12\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">301</span><span class=\"code\">\tend.</span></span>\n<span class=\"line \"><span class=\"ln\">302</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">303</span><span class=\"code\">execute(_, _, []) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">304</span><span class=\"code\">\tok;</span></span>\n<span class=\"line \"><span class=\"ln\">305</span><span class=\"code\">execute(Req, Env, [Middleware|Tail]) -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">306</span><span class=\"code\">\tcase Middleware:execute(Req, Env) of</span></span>\n<span class=\"line \"><span class=\"ln\">307</span><span class=\"code\">\t\t{ok, Req2, Env2} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">308</span><span class=\"code\">\t\t\texecute(Req2, Env2, Tail);</span></span>\n<span class=\"line \"><span class=\"ln\">309</span><span class=\"code\">\t\t{suspend, Module, Function, Args} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">310</span><span class=\"code\">\t\t\tproc_lib:hibernate(?MODULE, resume, [Env, Tail, Module, Function, Args]);</span></span>\n<span class=\"line \"><span class=\"ln\">311</span><span class=\"code\">\t\t{stop, _Req2} -&gt;</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_stream_h.execute/3\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"13\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">290</span><span class=\"code\">%% to simplify the debugging of errors. The proc_lib library</span></span>\n<span class=\"line \"><span class=\"ln\">291</span><span class=\"code\">%% already adds the stacktrace to other types of exceptions.</span></span>\n<span class=\"line \"><span class=\"ln\">292</span><span class=\"code\">-spec request_process(cowboy_req:req(), cowboy_middleware:env(), [module()]) -&gt; ok.</span></span>\n<span class=\"line \"><span class=\"ln\">293</span><span class=\"code\">request_process(Req, Env, Middlewares) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">294</span><span class=\"code\">\ttry</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">295</span><span class=\"code\">\t\texecute(Req, Env, Middlewares)</span></span>\n<span class=\"line \"><span class=\"ln\">296</span><span class=\"code\">\tcatch</span></span>\n<span class=\"line \"><span class=\"ln\">297</span><span class=\"code\">\t\texit:Reason={shutdown, _}:Stacktrace -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">298</span><span class=\"code\">\t\t\terlang:raise(exit, Reason, Stacktrace);</span></span>\n<span class=\"line \"><span class=\"ln\">299</span><span class=\"code\">\t\texit:Reason:Stacktrace when Reason =/= normal, Reason =/= shutdown -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">300</span><span class=\"code\">\t\t\terlang:raise(exit, {Reason, Stacktrace}, Stacktrace)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_stream_h.request_process/3\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"14\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">proc_lib.erl</a>\n                    </div>\n\n                    \n                    <div class=\"code code-block-empty\">No code available.</div>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :proc_lib.init_p_do_apply/3\n                            \n                            \n                                <span class=\"app right\">stdlib</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n            </div>\n\n            <div class=\"stack-trace\">\n                <div class=\"stack-trace-heading\">\n                    <label><input type=\"checkbox\" role=\"show-all-toggle\">Show only app frames</label>\n                </div>\n\n                <ul class=\"stack-trace-list -show-all\" role=\"stack-trace-list\">\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"0\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/live/page_live.ex<span class=\"line\">:14</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.PageLive.mount/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"1\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/utils.ex<span class=\"line\">:312</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">anonymous fn/4 in Phoenix.LiveView.Utils.maybe_call_live_view_mount!/4</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"2\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">telemetry</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl<span class=\"line\">:272</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:telemetry.span/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"3\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/static.ex<span class=\"line\">:302</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Static.call_mount_and_handle_params!/5</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"4\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/static.ex<span class=\"line\">:127</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Static.render/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"5\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/controller.ex<span class=\"line\">:35</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Controller.live_render/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"6\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix/router.ex<span class=\"line\">:352</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.Router.__call__/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"7\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/endpoint.ex<span class=\"line\">:1</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.plug_builder_call/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"8\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/plug/debugger.ex<span class=\"line\">:136</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.&quot;call (overridable 3)&quot;/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"9\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/endpoint.ex<span class=\"line\">:1</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.call/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"10\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix/endpoint/cowboy2_handler.ex<span class=\"line\">:65</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.Endpoint.Cowboy2Handler.init/4</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"11\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl<span class=\"line\">:37</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_handler.execute/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"12\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl<span class=\"line\">:306</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_stream_h.execute/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"13\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl<span class=\"line\">:295</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_stream_h.request_process/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"14\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">stdlib</span>\n                                \n\n                                <span class=\"filename\">\n                                    proc_lib.erl<span class=\"line\">:226</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:proc_lib.init_p_do_apply/3</span>\n                        </button>\n                    </li>\n                    \n                </ul>\n            </div>\n        </div>\n    </div>\n\n    <div class=\"conn-info\">\n        \n\n        <details class=\"conn-details\">\n            <summary>Request info</summary>\n\n            <dl>\n                <dt>URI:</dt>\n                <dd class=\"code-quote\">http://localhost:4000/</dd>\n            </dl>\n\n            <dl>\n                <dt>Query string:</dt>\n                <dd class=\"code-quote\"></dd>\n            </dl>\n        </details>\n\n        <details class=\"conn-details\">\n            <summary>Headers</summary>\n            \n            <dl>\n                <dt>accept</dt>\n                <dd class=\"code-quote\">text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9</dd>\n            </dl>\n            \n            <dl>\n                <dt>accept-encoding</dt>\n                <dd class=\"code-quote\">gzip, deflate, br</dd>\n            </dl>\n            \n            <dl>\n                <dt>accept-language</dt>\n                <dd class=\"code-quote\">en-US,en;q=0.9</dd>\n            </dl>\n            \n            <dl>\n                <dt>cache-control</dt>\n                <dd class=\"code-quote\">no-cache</dd>\n            </dl>\n            \n            <dl>\n                <dt>connection</dt>\n                <dd class=\"code-quote\">keep-alive</dd>\n            </dl>\n            \n            <dl>\n                <dt>cookie</dt>\n                <dd class=\"code-quote\">_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik</dd>\n            </dl>\n            \n            <dl>\n                <dt>host</dt>\n                <dd class=\"code-quote\">localhost:4000</dd>\n            </dl>\n            \n            <dl>\n                <dt>pragma</dt>\n                <dd class=\"code-quote\">no-cache</dd>\n            </dl>\n            \n            <dl>\n                <dt>referer</dt>\n                <dd class=\"code-quote\">http://localhost:4000/</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-dest</dt>\n                <dd class=\"code-quote\">document</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-mode</dt>\n                <dd class=\"code-quote\">navigate</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-site</dt>\n                <dd class=\"code-quote\">same-origin</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-user</dt>\n                <dd class=\"code-quote\">?1</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-gpc</dt>\n                <dd class=\"code-quote\">1</dd>\n            </dl>\n            \n            <dl>\n                <dt>upgrade-insecure-requests</dt>\n                <dd class=\"code-quote\">1</dd>\n            </dl>\n            \n            <dl>\n                <dt>user-agent</dt>\n                <dd class=\"code-quote\">Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36</dd>\n            </dl>\n            \n        </details>\n\n        \n        <details class=\"conn-details\">\n            <summary>Session</summary>\n            \n            <dl>\n                <dt>_csrf_token</dt>\n                <dd><pre>&quot;626LE-xkix70s3s1wbOaTjJs&quot;</pre></dd>\n            </dl>\n            \n        </details>\n        \n    </div>\n\n    <script>(function () {\n        var $items = document.querySelectorAll('[role~=\"stack-trace-item\"]')\n        var $toggle = document.querySelector('[role~=\"show-all-toggle\"]')\n        var $list = document.querySelector('[role~=\"stack-trace-list\"]')\n\n        each($items, function ($item) {\n            on($item, 'click', itemOnclick)\n        })\n\n        on($toggle, 'click', toggleOnclick)\n\n        function toggleOnclick () {\n            if (this.checked) {\n                var $first = document.querySelector('[role~=\"stack-trace-item\"].-app:first-of-type')\n                if ($first) itemOnclick.call($first)\n                removeClass($list, '-show-all')\n            } else {\n                addClass($list, '-show-all')\n            }\n        }\n\n        function itemOnclick () {\n            var idx = this.getAttribute('data-index')\n\n            var $detail = document.querySelector('[role~=\"stack-trace-details\"].-active')\n            if ($detail) removeClass($detail, '-active')\n\n            $detail = document.querySelector('[role~=\"stack-trace-details\"][data-index=\"' + idx + '\"]')\n            if ($detail) addClass($detail, '-active')\n\n            var $item = document.querySelector('[role~=\"stack-trace-item\"].-active')\n            if ($item) removeClass($item, '-active')\n\n            $item = document.querySelector('[role~=\"stack-trace-item\"][data-index=\"' + idx + '\"]')\n            if ($item) addClass($item, '-active')\n        }\n\n        var $first = document.querySelector('[role~=\"stack-trace-item\"]:first-of-type')\n        if ($first) itemOnclick.call($first)\n\n        /*\n         * Helpers\n         */\n\n        function each (list, fn) {\n            for (var i = 0, len = list.length; i < len; i++) {\n                var item = list[i]\n                fn(item)\n            }\n        }\n\n        function addClass (el, className) {\n            if (el.classList) {\n                el.classList.add(className)\n            } else {\n                el.className += ' ' + className\n            }\n        }\n\n        function removeClass (el, className) {\n            if (el.classList) {\n                el.classList.remove(className)\n            } else {\n                var expr = new RegExp('(^|\\\\b)' + className.split(' ').join('|') + '(\\\\b|$)', 'gi')\n                el.className = el.className.replace(expr, ' ')\n            }\n        }\n\n        function on (el, event, handler) {\n            if (el.addEventListener) {\n                el.addEventListener(event, handler)\n            } else {\n                el.attachEvent('on' + event, function () {\n                    handler.call(el)\n                })\n            }\n        }\n    }())</script>\n</body>\n</html>\n",
        resp_cookies: %{},
        resp_headers: [
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8SAuHxGnfy3gAABMU"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"content-type", "text/html; charset=utf-8"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 500
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 41348},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 41478},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 253_716_655},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 7,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U0h3eWhGY0lReHNTZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgDHjpLpeQFiAAFRgA.2eG8zyQrcWDej2HHc1Ze0YNl9LG5x5mAeEUj4xQUv5c",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U0h3eWhGY0lReHNTbgYAx46S6XkBYgABUYA.CByNeIn9aQVQBg6Xzz69UlyAK96Hs0PNmebUugXFIww",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8SHwyhFcIQxsS", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "fWh0LzVsCFJaHllkBGM5ZEIIEBdjJiI9KZBcpAp93fnTwPJU5j_v7LhN", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U0h3eWhGY0lReHNTZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgDHjpLpeQFiAAFRgA.2eG8zyQrcWDej2HHc1Ze0YNl9LG5x5mAeEUj4xQUv5c",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U0h3eWhGY0lReHNTbgYAx46S6XkBYgABUYA.CByNeIn9aQVQBg6Xzz69UlyAK96Hs0PNmebUugXFIww",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8SHwyhFcIQxsS", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8SHwdv3JKCEMAABqS"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 55094},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 58199},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 252_908_168},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45808},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 7,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U05XXy11X0VJd0VNZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCllJLpeQFiAAFRgA.S_rp6kFB1pnUzgC0zUIXHaNiQ-pJcK4lLhyIW8ErPDw",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U05XXy11X0VJd0VNbgYApZSS6XkBYgABUYA.sFqcYet5-3QBHL_a1jH2vTunWuCAZrTMykZnbhp1iFU",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8SNW_-u_EIwEM", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "YGBxdDxIKhE8L09bFEMhcEY2Nwh5XS9LVRG8yeRzUWxkgpRA1Txi-7e8", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U05XXy11X0VJd0VNZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCllJLpeQFiAAFRgA.S_rp6kFB1pnUzgC0zUIXHaNiQ-pJcK4lLhyIW8ErPDw",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U05XXy11X0VJd0VNbgYApZSS6XkBYgABUYA.sFqcYet5-3QBHL_a1jH2vTunWuCAZrTMykZnbhp1iFU",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8SNW_-u_EIwEM", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8SNWsRGPrxCMAAACM"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 43602},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 44193},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 336_150_273},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45808},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 10,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U3dZd0NwTGluZ0NEZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCzuZLpeQFiAAFRgA.3J-1imfkYgiWDz8HpgTl0aXG60Iqxu5aYoh_0vJ4X-w",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U3dZd0NwTGluZ0NEbgYAs7mS6XkBYgABUYA.N603djr3gsNsdDlyBoVi1_wrWGP4O281nVO9nr5-1ZY",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8SwYwCpLingCD", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "T2dFExdHHlovClZGS3I0SxQJHFIEOR1KyUs_Rjf1Frav8AGzckS3PSW9", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4U3dZd0NwTGluZ0NEZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCzuZLpeQFiAAFRgA.3J-1imfkYgiWDz8HpgTl0aXG60Iqxu5aYoh_0vJ4X-w",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4U3dZd0NwTGluZ0NEbgYAs7mS6XkBYgABUYA.N603djr3gsNsdDlyBoVi1_wrWGP4O281nVO9nr5-1ZY",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8SwYwCpLingCD", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8SwYi67pU4p4AAAAD"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 39665},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 74059},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_handled_in],
    measurements: %{duration: 51792},
    metadata: %{
      event: "test_event",
      params: %{},
      ref: "10",
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        joined: true,
        join_ref: "6",
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_handled_in],
    measurements: %{duration: 51792},
    metadata: %{
      event: "another_test_event",
      params: %{},
      ref: "10",
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        joined: true,
        join_ref: "6",
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 501_930_627},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45812},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 11,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UzcxSU5UeWpveFVUZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgBaxpLpeQFiAAFRgA.tV7G3OY-A1N96u4E6-OcJt0dZ5_hpfDxq2woHQUhBcg",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UzcxSU5UeWpveFVUbgYAWsaS6XkBYgABUYA.chMrjRVXdv-6fU2pwZRg4bTvRDCGbFpw39Qk8P7TjEg",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8S71INTyjoxUT", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "RQQEOg10ISIlT3pTEUYRBUEGGFA2Pg8js62vHYYIL7Mcbub46dW1bTEP", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4UzcxSU5UeWpveFVUZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgBaxpLpeQFiAAFRgA.tV7G3OY-A1N96u4E6-OcJt0dZ5_hpfDxq2woHQUhBcg",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4UzcxSU5UeWpveFVUbgYAWsaS6XkBYgABUYA.chMrjRVXdv-6fU2pwZRg4bTvRDCGbFpw39Qk8P7TjEg",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8S71INTyjoxUT", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8S7075lIRo6MAABST"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 43472},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 6_612_112},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45808},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 15,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body:
          "<!DOCTYPE html>\n<html>\n<head>\n    <meta charset=\"utf-8\">\n    <title>ArithmeticError at GET /</title>\n    <meta name=\"viewport\" content=\"width=device-width\">\n    <style>/*! normalize.css v4.2.0 | MIT License | github.com/necolas/normalize.css */html{font-family:sans-serif;line-height:1.15;-ms-text-size-adjust:100%;-webkit-text-size-adjust:100%}body{margin:0}article,aside,details,figcaption,figure,footer,header,main,menu,nav,section{display:block}audio,canvas,progress,video{display:inline-block}audio:not([controls]){display:none;height:0}progress{vertical-align:baseline}template,[hidden]{display:none}a{background-color:transparent;-webkit-text-decoration-skip:objects}a:active,a:hover{outline-width:0}abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}b,strong{font-weight:inherit}b,strong{font-weight:bolder}dfn{font-style:italic}h1{font-size:2em;margin:0.67em 0}mark{background-color:#ff0;color:#000}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-0.25em}sup{top:-0.5em}img{border-style:none}svg:not(:root){overflow:hidden}code,kbd,pre,samp{font-family:monospace, monospace;font-size:1em}figure{margin:1em 40px}hr{box-sizing:content-box;height:0;overflow:visible}button,input,optgroup,select,textarea{font:inherit;margin:0}optgroup{font-weight:bold}button,input{overflow:visible}button,select{text-transform:none}button,html [type=\"button\"],[type=\"reset\"],[type=\"submit\"]{-webkit-appearance:button}button::-moz-focus-inner,[type=\"button\"]::-moz-focus-inner,[type=\"reset\"]::-moz-focus-inner,[type=\"submit\"]::-moz-focus-inner{border-style:none;padding:0}button:-moz-focusring,[type=\"button\"]:-moz-focusring,[type=\"reset\"]:-moz-focusring,[type=\"submit\"]:-moz-focusring{outline:1px dotted ButtonText}fieldset{border:1px solid #c0c0c0;margin:0 2px;padding:0.35em 0.625em 0.75em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}textarea{overflow:auto}[type=\"checkbox\"],[type=\"radio\"]{box-sizing:border-box;padding:0}[type=\"number\"]::-webkit-inner-spin-button,[type=\"number\"]::-webkit-outer-spin-button{height:auto}[type=\"search\"]{-webkit-appearance:textfield;outline-offset:-2px}[type=\"search\"]::-webkit-search-cancel-button,[type=\"search\"]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-input-placeholder{color:inherit;opacity:0.54}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}</style>\n    <style>\n    html, body, td, input {\n        font-family: -apple-system, BlinkMacSystemFont, \"Segoe UI\", \"Roboto\", \"Oxygen\", \"Ubuntu\", \"Cantarell\", \"Fira Sans\", \"Droid Sans\", \"Helvetica Neue\", sans-serif;\n    }\n\n    * {\n        box-sizing: border-box;\n    }\n\n    html {\n        font-size: 15px;\n        line-height: 1.6;\n        background: #fff;\n        color: #203040;\n    }\n\n    @media (max-width: 768px) {\n        html {\n             font-size: 14px;\n        }\n    }\n\n    @media (max-width: 480px) {\n        html {\n             font-size: 13px;\n        }\n    }\n\n    button:focus,\n    summary:focus {\n        outline: 0;\n    }\n\n    summary {\n        cursor: pointer;\n    }\n\n    pre {\n        font-family: menlo, consolas, monospace;\n        overflow: auto;\n        max-width: 100%;\n    }\n\n    .top-details {\n        padding: 48px;\n        background: #f9f9fa;\n    }\n\n    .top-details,\n    .conn-info {\n        padding: 48px;\n    }\n\n\n    @media (max-width: 768px) {\n        .top-details,\n        .conn-info {\n            padding: 32px;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .top-details,\n        .conn-info {\n            padding: 16px;\n        }\n    }\n\n    /*\n     * Exception logo\n     */\n\n    \n    .exception-logo {\n        position: absolute;\n        right: 48px;\n        top: 48px;\n        pointer-events: none;\n        width: 100%;\n    }\n\n    .exception-logo:before {\n        content: '';\n        display: block;\n        height: 64px;\n        width: 100%;\n        background-size: auto 100%;\n        background-image: url(\"data:image/png;base64,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\");\n        background-position: right 0;\n        background-repeat: no-repeat;\n        margin-bottom: 16px;\n    }\n\n    @media (max-width: 768px) {\n        .exception-logo {\n            position: static;\n        }\n\n        .exception-logo:before {\n            height: 32px;\n            background-position: left 0;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .exception-logo {\n            display: none;\n        }\n    }\n    \n\n    /*\n     * Exception info\n     */\n\n    /* Compensate for logo placement */\n    @media (min-width: 769px) {\n        .exception-info {\n            max-width: 90%;\n        }\n    }\n\n    .exception-info > .struct,\n    .exception-info > .title,\n    .exception-info > .detail {\n        margin: 0;\n        padding: 0;\n    }\n\n    .exception-info > .struct {\n        font-size: 1em;\n        font-weight: 700;\n        color: #EB532D;\n    }\n\n    .exception-info > .struct > small {\n        font-size: 1em;\n        color: #607080;\n        font-weight: 400;\n    }\n\n    .exception-info > .title {\n        font-size: 2.0736em;\n        line-height: 1.4;\n        font-weight: 300;\n        color: #EB532D;\n    }\n\n    @media (max-width: 768px) {\n        .exception-info > .title {\n            font-size: 1.7490062499999994em;\n        }\n    }\n\n    @media (max-width: 480px) {\n        .exception-info > .title {\n            font-size: 1.4641000000000004em;\n        }\n    }\n\n    .exception-info > .detail {\n        margin-top: 1.3em;\n        white-space: pre-wrap;\n    }\n\n    /*\n     * Code explorer\n     */\n\n    .code-explorer {\n      margin: 32px 0 0 0;\n    }\n\n    @media (max-width: 768px) {\n        .code-explorer {\n            margin-top: 16px;\n        }\n    }\n\n    .code-explorer:after {\n        content: '';\n        display: table;\n        clear: both;\n        zoom: 1;\n    }\n\n    .code-explorer > .code-snippets {\n        float: left;\n        width: 45%;\n    }\n\n    .code-explorer > .stack-trace {\n        float: right;\n        width: 55%;\n        padding-left: 32px;\n    }\n\n    /* Collapse to single-column */\n    @media (max-width: 960px) {\n        .code-explorer > .code-snippets {\n            float: none;\n            width: auto;\n            margin-bottom: 16px;\n        }\n\n        .code-explorer > .stack-trace {\n            float: none;\n            width: auto;\n            padding-left: 0;\n        }\n    }\n\n    /*\n     * Frame info:\n     * Holds the code (code-block) and more\n     */\n\n    .frame-info {\n        background: white;\n        box-shadow:\n            0 1px 3px rgba(80, 100, 140, .1),\n            0 8px 15px rgba(80, 100, 140, .05);\n    }\n\n    .frame-info > .meta,\n    .frame-info > .file {\n        padding: 12px 16px;\n        white-space: no-wrap;\n        font-size: 0.8333333333333334em;\n    }\n\n    @media (max-width: 480px) {\n        .frame-info > .meta,\n        .frame-info > .file {\n            padding: 6px 16px;\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    .frame-info > .file > a {\n        text-decoration: none;\n        color: #203040;\n        font-weight: 700;\n    }\n\n    .frame-info > .code {\n        border-top: solid 1px #eee;\n        border-bottom: solid 1px #eee;\n        font-size: 0.8em;\n    }\n\n    /* Hiding */\n    .frame-info {\n        display: none;\n    }\n\n    .frame-info.-active {\n        display: block;\n    }\n\n    .frame-info > details.meta {\n        border-top: solid 1px #eee;\n        padding: 0;\n    }\n\n    .frame-info > details.meta > summary {\n        padding: 12px 16px;\n    }\n\n    .frame-info > details.meta > pre {\n        line-height: 16px;\n        padding: 6px 0 24px 30px;\n    }\n\n    .frame-info > details.meta > ol {\n        counter-reset: item;\n        padding: 6px 0 24px 46px;\n        list-style: none;\n    }\n\n    .frame-info > details.meta > ol > li {\n        counter-increment: item;\n    }\n\n    .frame-info > details.meta > ol > li:before {\n        content: counter(item) \". \";\n        color: #607080;\n    }\n\n    /*\n     * Frame details\n     */\n\n    .frame-mfa {\n        color: #607080;\n    }\n\n    .frame-mfa > .app {\n        color: #607080;\n    }\n\n    .frame-mfa > .docs {\n        color: #EB532D;\n        text-decoration: none;\n    }\n\n    .frame-mfa .docs:hover {\n        text-decoration: underline;\n    }\n\n    .frame-mfa > .right {\n        float: right;\n        padding-left: 5px;\n    }\n\n    .frame-mfa > .right:after {\n        content: '·';\n        margin-left: .2em;\n        padding-left: .2em;\n    }\n\n    .frame-mfa > .right:first-child:after {\n        content: '';\n    }\n\n    /*\n     * Code block:\n     * The `pre` that holds the code\n     */\n\n    .code-block {\n        margin: 0;\n        padding: 12px 0;\n        font-size: 0.8333333333333334em;\n        line-height: 1.4;\n        white-space: normal;\n    }\n\n    .code-block > .line {\n        white-space: pre;\n        display: block;\n        padding: 0 16px;\n    }\n\n    /* Line highlight */\n    .code-block > .line.-highlight {\n        background-color: #f0f4fa;\n        -webkit-animation: line-highlight 750ms linear;\n        animation: line-highlight 750ms linear;\n    }\n\n    @-webkit-keyframes line-highlight {\n        0% { background-color: #f0f4fa; }\n        25% { background-color: #ffe5e5; }\n        50% { background-color: #f0f4fa; }\n        75% { background-color: #ffe5e5; }\n    }\n\n    @keyframes line-highlight {\n        0% { background-color: #f0f4fa; }\n        25% { background-color: #ffe5e5; }\n        50% { background-color: #f0f4fa; }\n        75% { background-color: #ffe5e5; }\n    }\n\n    .code-block > .line > .ln {\n        color: #607080;\n        margin-right: 1.5em;\n        -webkit-user-select: none;\n        -moz-user-select: none;\n        -ms-user-select: none;\n        user-select: none;\n    }\n\n    .code-block > .line > .code {\n        font-family: menlo, consolas, monospace;\n    }\n\n    /*\n     * Empty code\n     */\n\n    .code-block-empty {\n        text-align: center;\n        color: #607080;\n        padding-top: 48px;\n        padding-bottom: 48px;\n    }\n\n    /*\n     * Stack trace heading\n     */\n\n    .stack-trace-heading {\n        padding-top: 8px;\n    }\n\n    .stack-trace-heading:after {\n        content: '';\n        display: block;\n        clear: both;\n        zoom: 1;\n        border-bottom: solid 1px #eee;\n        padding-top: 12px;\n        margin-bottom: 16px;\n    }\n\n    .stack-trace-heading > h3 {\n        display: none;\n    }\n\n    .stack-trace-heading > label {\n        display: block;\n        padding-left: 8px;\n        line-height: 1.9;\n        font-size: 0.8333333333333334em;\n        -webkit-user-select: none;\n        -moz-user-select: none;\n        -ms-user-select: none;\n        user-select: none;\n    }\n\n    .stack-trace-heading > label > input {\n        margin-right: .3em;\n    }\n\n    @media (max-width: 480px) {\n        .stack-trace-heading > label {\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    /*\n     * Stack trace\n     */\n\n    .stack-trace-list,\n    .stack-trace-list > li {\n        margin: 0;\n        padding: 0;\n        list-style-type: none;\n    }\n\n    .stack-trace-list > li > .stack-trace-item.-all {\n        display: none;\n    }\n\n    .stack-trace-list.-show-all > li > .stack-trace-item.-all {\n        display: block;\n    }\n\n    /*\n     * Stack trace item:\n     * The clickable line to inspect a stack trace\n     */\n\n    .stack-trace-item {\n        font-size: 0.8333333333333334em;\n        display: block;\n        width: 100%;\n        border: 0;\n        margin: 0;\n        padding: 4px 8px;\n        background: transparent;\n        cursor: pointer;\n        text-align: left;\n        overflow: hidden;\n        white-space: nowrap;\n    }\n\n    .stack-trace-item:hover,\n    .stack-trace-item:focus {\n        background-color: rgba(80, 100, 140, 0.05);\n    }\n\n    .stack-trace-item,\n    .stack-trace-item:active {\n        color: #203040;\n    }\n\n    .stack-trace-item:active {\n        background-color: rgba(80, 100, 140, 0.1);\n    }\n\n    .stack-trace-item.-active {\n        background-color: white;\n    }\n\n    /* Circle */\n    .stack-trace-item > .left:before {\n        content: '';\n        display: inline-block;\n        width: 8px;\n        height: 8px;\n        background: #a0b0c0;\n        border-radius: 50%;\n        margin-right: 8px;\n    }\n\n    .stack-trace-item.-app > .left:before {\n        background: #EB532D;\n        opacity: 1;\n    }\n\n    .stack-trace-item.-app > .left > .app {\n        display: none;\n    }\n\n    .stack-trace-item > .left {\n        float: left;\n        max-width: 55%;\n    }\n\n    .stack-trace-item > .info {\n        color: #607080;\n        float: right;\n        max-width: 45%;\n    }\n\n    .stack-trace-item > .left,\n    .stack-trace-item > .info {\n        white-space: nowrap;\n        overflow: hidden;\n        text-overflow: ellipsis;\n    }\n\n    .stack-trace-item > .left > .filename > .line {\n        color: #607080;\n    }\n\n    /* App name */\n    .stack-trace-item > .left > .app {\n        color: #607080;\n    }\n\n    .stack-trace-item > .left > .app:after {\n        content: '·';\n        margin: 0 .2em;\n    }\n\n    /*\n     * Code as a blockquote:\n     * Like `pre` but with wrapping\n     */\n\n    .code-quote {\n        font-family: menlo, consolas, monospace;\n        font-size: 0.8333333333333334em;\n        margin: 0;\n        overflow: auto;\n        max-width: 100%;\n        word-wrap: break-word;\n        white-space: normal;\n    }\n\n    .code.-padded {\n        padding: 0 16px 16px 16px;\n    }\n\n    .code i.red {\n        color: #CC0000;\n        font-style: normal;\n    }\n\n    .code i.green {\n        font-style: normal;\n    }\n\n    .banner {\n      padding: 24px 48px 24px 48px;\n      border-top: solid 1px #eee;\n    }\n\n    /*\n     * Conn info\n     */\n\n    .conn-info {\n        border-top: solid 1px #eee;\n    }\n\n    /*\n     * Conn details\n     */\n\n    .conn-details {\n    }\n\n    .conn-details + .conn-details {\n        margin-top: 16px;\n    }\n\n    .conn-details > summary {\n    }\n\n    .conn-details > dl {\n        display: block;\n        overflow: hidden;\n        margin: 0;\n        padding: 4px 0;\n        border-bottom: solid 1px #eee;\n        white-space: nowrap;\n        text-overflow: ellipsis;\n    }\n\n    .conn-details > dl:first-of-type {\n        margin-top: 16px;\n        border-top: solid 1px #eee;\n    }\n\n    /* Term */\n    .conn-details > dl > dt {\n        width: 20%;\n        float: left;\n        font-size: 0.8333333333333334em;\n        color: #607080;\n        overflow: hidden;\n        text-overflow: ellipsis;\n        position: relative;\n        top: -1px; /* Compensate for font metrics */\n    }\n\n    /* Definition */\n    .conn-details > dl > dd {\n        width: 80%;\n        float: left;\n    }\n\n    @media (max-width: 480px) {\n        .conn-details > dl > dt {\n            font-size: 0.9090909090909091em;\n        }\n    }\n\n    .action-form {\n        display: inline-block;\n        margin: 20px 10px 5px 0;\n    }\n\n    .action-button:hover {\n        background-color: #f9f9fa;\n        cursor: pointer;\n    }\n\n    .action-button {\n        background-color: white;\n        border: 1px solid #EB532D;\n        border-radius: 3px;\n        color: #EB532D;\n        padding: 0 20px;\n    }\n\n    .action-button:active {\n        background-color: inherit;\n        background-color: #f2f2f4;\n    }\n    </style>\n</head>\n<body>\n    <div class=\"top-details\">\n        \n        <aside class=\"exception-logo\"></aside>\n        \n\n        <header class=\"exception-info\">\n            \n            <h5 class=\"struct\">\n                ArithmeticError\n                <small>at GET</small>\n                <small class=\"path\">/</small>\n            </h5>\n            <h1 class=\"title\">bad argument in arithmetic expression</h1>\n            \n        </header>\n\n        \n\n    \n\n        <div class=\"code-explorer\">\n            <div class=\"code-snippets\">\n                \n                  <div class=\"frame-info\" data-index=\"0\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/live/page_live.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">9</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">10</span><span class=\"code\">      2 -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">11</span><span class=\"code\">        Process.sleep(500)</span></span>\n<span class=\"line \"><span class=\"ln\">12</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">13</span><span class=\"code\">      val -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">14</span><span class=\"code\">        Process.sleep(floor(1_000 / val))</span></span>\n<span class=\"line \"><span class=\"ln\">15</span><span class=\"code\">    end</span></span>\n<span class=\"line \"><span class=\"ln\">16</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">17</span><span class=\"code\">    {:ok, assign(socket, query: &quot;&quot;, results: %{})}</span></span>\n<span class=\"line \"><span class=\"ln\">18</span><span class=\"code\">  end</span></span>\n<span class=\"line \"><span class=\"ln\">19</span><span class=\"code\"></span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.PageLive.mount/3\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"1\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/utils.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">307</span><span class=\"code\">        [:phoenix, :live_view, :mount],</span></span>\n<span class=\"line \"><span class=\"ln\">308</span><span class=\"code\">        %{socket: socket, params: params, session: session},</span></span>\n<span class=\"line \"><span class=\"ln\">309</span><span class=\"code\">        fn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">310</span><span class=\"code\">          socket =</span></span>\n<span class=\"line \"><span class=\"ln\">311</span><span class=\"code\">            params</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">312</span><span class=\"code\">            |&gt; view.mount(session, socket)</span></span>\n<span class=\"line \"><span class=\"ln\">313</span><span class=\"code\">            |&gt; handle_mount_result!({:mount, 3, view})</span></span>\n<span class=\"line \"><span class=\"ln\">314</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">315</span><span class=\"code\">          {socket, %{socket: socket, params: params, session: session}}</span></span>\n<span class=\"line \"><span class=\"ln\">316</span><span class=\"code\">        end</span></span>\n<span class=\"line \"><span class=\"ln\">317</span><span class=\"code\">      )</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            anonymous fn/4 in Phoenix.LiveView.Utils.maybe_call_live_view_mount!/4\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"2\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">267</span><span class=\"code\">span(EventPrefix, StartMetadata, SpanFunction) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">268</span><span class=\"code\">    StartTime = erlang:monotonic_time(),</span></span>\n<span class=\"line \"><span class=\"ln\">269</span><span class=\"code\">    DefaultCtx = erlang:make_ref(),</span></span>\n<span class=\"line \"><span class=\"ln\">270</span><span class=\"code\">    execute(EventPrefix ++ [start], \#{system_time =&gt; erlang:system_time()}, merge_ctx(StartMetadata, DefaultCtx)),</span></span>\n<span class=\"line \"><span class=\"ln\">271</span><span class=\"code\"></span></span>\n<span class=\"line -highlight\"><span class=\"ln\">272</span><span class=\"code\">    try {_, \#{}} = SpanFunction() of</span></span>\n<span class=\"line \"><span class=\"ln\">273</span><span class=\"code\">      {Result, StopMetadata} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">274</span><span class=\"code\">          execute(EventPrefix ++ [stop], \#{duration =&gt; erlang:monotonic_time() - StartTime}, merge_ctx(StopMetadata, DefaultCtx)),</span></span>\n<span class=\"line \"><span class=\"ln\">275</span><span class=\"code\">          Result</span></span>\n<span class=\"line \"><span class=\"ln\">276</span><span class=\"code\">    catch</span></span>\n<span class=\"line \"><span class=\"ln\">277</span><span class=\"code\">        ?WITH_STACKTRACE(Class, Reason, Stacktrace)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :telemetry.span/3\n                            \n                            \n                                <span class=\"app right\">telemetry</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"3\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/static.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">297</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">298</span><span class=\"code\">  defp call_mount_and_handle_params!(socket, view, session, params, uri) do</span></span>\n<span class=\"line \"><span class=\"ln\">299</span><span class=\"code\">    mount_params = if socket.router, do: params, else: :not_mounted_at_router</span></span>\n<span class=\"line \"><span class=\"ln\">300</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">301</span><span class=\"code\">    socket</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">302</span><span class=\"code\">    |&gt; Utils.maybe_call_live_view_mount!(view, mount_params, session)</span></span>\n<span class=\"line \"><span class=\"ln\">303</span><span class=\"code\">    |&gt; mount_handle_params(view, params, uri)</span></span>\n<span class=\"line \"><span class=\"ln\">304</span><span class=\"code\">    |&gt; case do</span></span>\n<span class=\"line \"><span class=\"ln\">305</span><span class=\"code\">      {:noreply, %Socket{redirected: {:live, _, _}} = socket} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">306</span><span class=\"code\">        {:stop, socket}</span></span>\n<span class=\"line \"><span class=\"ln\">307</span><span class=\"code\"></span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Static.call_mount_and_handle_params!/5\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"4\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/static.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">122</span><span class=\"code\">        action,</span></span>\n<span class=\"line \"><span class=\"ln\">123</span><span class=\"code\">        flash,</span></span>\n<span class=\"line \"><span class=\"ln\">124</span><span class=\"code\">        host_uri</span></span>\n<span class=\"line \"><span class=\"ln\">125</span><span class=\"code\">      )</span></span>\n<span class=\"line \"><span class=\"ln\">126</span><span class=\"code\"></span></span>\n<span class=\"line -highlight\"><span class=\"ln\">127</span><span class=\"code\">    case call_mount_and_handle_params!(socket, view, mount_session, conn.params, request_url) do</span></span>\n<span class=\"line \"><span class=\"ln\">128</span><span class=\"code\">      {:ok, socket} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">129</span><span class=\"code\">        data_attrs = [</span></span>\n<span class=\"line \"><span class=\"ln\">130</span><span class=\"code\">          phx_view: config.name,</span></span>\n<span class=\"line \"><span class=\"ln\">131</span><span class=\"code\">          phx_session: sign_root_session(socket, router, view, to_sign_session),</span></span>\n<span class=\"line \"><span class=\"ln\">132</span><span class=\"code\">          phx_static: sign_static_token(socket)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Static.render/3\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"5\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix_live_view/controller.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">30</span><span class=\"code\">        end</span></span>\n<span class=\"line \"><span class=\"ln\">31</span><span class=\"code\">      end</span></span>\n<span class=\"line \"><span class=\"ln\">32</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">33</span><span class=\"code\">  &quot;&quot;&quot;</span></span>\n<span class=\"line \"><span class=\"ln\">34</span><span class=\"code\">  def live_render(%Plug.Conn{} = conn, view, opts \\\\ []) do</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">35</span><span class=\"code\">    case LiveView.Static.render(conn, view, opts) do</span></span>\n<span class=\"line \"><span class=\"ln\">36</span><span class=\"code\">      {:ok, content, socket_assigns} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">37</span><span class=\"code\">        conn</span></span>\n<span class=\"line \"><span class=\"ln\">38</span><span class=\"code\">        |&gt; Phoenix.Controller.put_view(LiveView.Static)</span></span>\n<span class=\"line \"><span class=\"ln\">39</span><span class=\"code\">        |&gt; LiveView.Plug.put_cache_headers()</span></span>\n<span class=\"line \"><span class=\"ln\">40</span><span class=\"code\">        |&gt; Phoenix.Controller.render(</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.LiveView.Controller.live_render/3\n                            \n                                <a class=\"docs right\" href=\"https://hexdocs.pm/phoenix_live_view/0.14.8/Phoenix.LiveView.Controller.html#live_render/3\">docs</a>\n                            \n                            \n                                <span class=\"app right\">phoenix_live_view</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"6\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix/router.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">347</span><span class=\"code\">    case pipeline.(conn) do</span></span>\n<span class=\"line \"><span class=\"ln\">348</span><span class=\"code\">      %Plug.Conn{halted: true} = halted_conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">349</span><span class=\"code\">        halted_conn</span></span>\n<span class=\"line \"><span class=\"ln\">350</span><span class=\"code\">      %Plug.Conn{} = piped_conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">351</span><span class=\"code\">        try do</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">352</span><span class=\"code\">          plug.call(piped_conn, plug.init(opts))</span></span>\n<span class=\"line \"><span class=\"ln\">353</span><span class=\"code\">        else</span></span>\n<span class=\"line \"><span class=\"ln\">354</span><span class=\"code\">          conn -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">355</span><span class=\"code\">            duration = System.monotonic_time() - start</span></span>\n<span class=\"line \"><span class=\"ln\">356</span><span class=\"code\">            metadata = %{metadata | conn: conn}</span></span>\n<span class=\"line \"><span class=\"ln\">357</span><span class=\"code\">            :telemetry.execute([:phoenix, :router_dispatch, :stop], %{duration: duration}, metadata)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.Router.__call__/2\n                            \n                            \n                                <span class=\"app right\">phoenix</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"7\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/endpoint.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line -highlight\"><span class=\"ln\">1</span><span class=\"code\">defmodule WebAppWeb.Endpoint do</span></span>\n<span class=\"line \"><span class=\"ln\">2</span><span class=\"code\">  use Phoenix.Endpoint, otp_app: :web_app</span></span>\n<span class=\"line \"><span class=\"ln\">3</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">4</span><span class=\"code\">  # The session will be stored in the cookie and signed,</span></span>\n<span class=\"line \"><span class=\"ln\">5</span><span class=\"code\">  # this means its contents can be read but not tampered with.</span></span>\n<span class=\"line \"><span class=\"ln\">6</span><span class=\"code\">  # Set :encryption_salt if you would also like to encrypt it.</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.plug_builder_call/2\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"8\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/plug/debugger.ex</a>\n                    </div>\n\n                    \n                    <div class=\"code code-block-empty\">No code available.</div>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.&quot;call (overridable 3)&quot;/2\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"9\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/web_app_web/endpoint.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line -highlight\"><span class=\"ln\">1</span><span class=\"code\">defmodule WebAppWeb.Endpoint do</span></span>\n<span class=\"line \"><span class=\"ln\">2</span><span class=\"code\">  use Phoenix.Endpoint, otp_app: :web_app</span></span>\n<span class=\"line \"><span class=\"ln\">3</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">4</span><span class=\"code\">  # The session will be stored in the cookie and signed,</span></span>\n<span class=\"line \"><span class=\"ln\">5</span><span class=\"code\">  # this means its contents can be read but not tampered with.</span></span>\n<span class=\"line \"><span class=\"ln\">6</span><span class=\"code\">  # Set :encryption_salt if you would also like to encrypt it.</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            WebAppWeb.Endpoint.call/2\n                            \n                                <a class=\"docs right\" href=\"https://hexdocs.pm/web_app/0.1.0/WebAppWeb.Endpoint.html#call/2\">docs</a>\n                            \n                            \n                                <span class=\"app right\">web_app</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"10\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">lib/phoenix/endpoint/cowboy2_handler.ex</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">60</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">61</span><span class=\"code\">        {:plug, conn, handler, opts} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">62</span><span class=\"code\">          %{adapter: {@connection, req}} =</span></span>\n<span class=\"line \"><span class=\"ln\">63</span><span class=\"code\">            conn =</span></span>\n<span class=\"line \"><span class=\"ln\">64</span><span class=\"code\">              conn</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">65</span><span class=\"code\">              |&gt; handler.call(opts)</span></span>\n<span class=\"line \"><span class=\"ln\">66</span><span class=\"code\">              |&gt; maybe_send(handler)</span></span>\n<span class=\"line \"><span class=\"ln\">67</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">68</span><span class=\"code\">          :telemetry.execute(</span></span>\n<span class=\"line \"><span class=\"ln\">69</span><span class=\"code\">            [:plug_adapter, :call, :stop],</span></span>\n<span class=\"line \"><span class=\"ln\">70</span><span class=\"code\">            %{duration: System.monotonic_time() - start},</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            Phoenix.Endpoint.Cowboy2Handler.init/4\n                            \n                            \n                                <span class=\"app right\">phoenix</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"11\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">32</span><span class=\"code\">-optional_callbacks([terminate/3]).</span></span>\n<span class=\"line \"><span class=\"ln\">33</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">34</span><span class=\"code\">-spec execute(Req, Env) -&gt; {ok, Req, Env}</span></span>\n<span class=\"line \"><span class=\"ln\">35</span><span class=\"code\">\twhen Req::cowboy_req:req(), Env::cowboy_middleware:env().</span></span>\n<span class=\"line \"><span class=\"ln\">36</span><span class=\"code\">execute(Req, Env=\#{handler := Handler, handler_opts := HandlerOpts}) -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">37</span><span class=\"code\">\ttry Handler:init(Req, HandlerOpts) of</span></span>\n<span class=\"line \"><span class=\"ln\">38</span><span class=\"code\">\t\t{ok, Req2, State} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">39</span><span class=\"code\">\t\t\tResult = terminate(normal, Req2, State, Handler),</span></span>\n<span class=\"line \"><span class=\"ln\">40</span><span class=\"code\">\t\t\t{ok, Req2, Env\#{result =&gt; Result}};</span></span>\n<span class=\"line \"><span class=\"ln\">41</span><span class=\"code\">\t\t{Mod, Req2, State} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">42</span><span class=\"code\">\t\t\tMod:upgrade(Req2, Env, Handler, State);</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_handler.execute/2\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"12\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">301</span><span class=\"code\">\tend.</span></span>\n<span class=\"line \"><span class=\"ln\">302</span><span class=\"code\"></span></span>\n<span class=\"line \"><span class=\"ln\">303</span><span class=\"code\">execute(_, _, []) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">304</span><span class=\"code\">\tok;</span></span>\n<span class=\"line \"><span class=\"ln\">305</span><span class=\"code\">execute(Req, Env, [Middleware|Tail]) -&gt;</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">306</span><span class=\"code\">\tcase Middleware:execute(Req, Env) of</span></span>\n<span class=\"line \"><span class=\"ln\">307</span><span class=\"code\">\t\t{ok, Req2, Env2} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">308</span><span class=\"code\">\t\t\texecute(Req2, Env2, Tail);</span></span>\n<span class=\"line \"><span class=\"ln\">309</span><span class=\"code\">\t\t{suspend, Module, Function, Args} -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">310</span><span class=\"code\">\t\t\tproc_lib:hibernate(?MODULE, resume, [Env, Tail, Module, Function, Args]);</span></span>\n<span class=\"line \"><span class=\"ln\">311</span><span class=\"code\">\t\t{stop, _Req2} -&gt;</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_stream_h.execute/3\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"13\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">/home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl</a>\n                    </div>\n\n                    \n<pre class=\"code code-block\"><span class=\"line \"><span class=\"ln\">290</span><span class=\"code\">%% to simplify the debugging of errors. The proc_lib library</span></span>\n<span class=\"line \"><span class=\"ln\">291</span><span class=\"code\">%% already adds the stacktrace to other types of exceptions.</span></span>\n<span class=\"line \"><span class=\"ln\">292</span><span class=\"code\">-spec request_process(cowboy_req:req(), cowboy_middleware:env(), [module()]) -&gt; ok.</span></span>\n<span class=\"line \"><span class=\"ln\">293</span><span class=\"code\">request_process(Req, Env, Middlewares) -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">294</span><span class=\"code\">\ttry</span></span>\n<span class=\"line -highlight\"><span class=\"ln\">295</span><span class=\"code\">\t\texecute(Req, Env, Middlewares)</span></span>\n<span class=\"line \"><span class=\"ln\">296</span><span class=\"code\">\tcatch</span></span>\n<span class=\"line \"><span class=\"ln\">297</span><span class=\"code\">\t\texit:Reason={shutdown, _}:Stacktrace -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">298</span><span class=\"code\">\t\t\terlang:raise(exit, Reason, Stacktrace);</span></span>\n<span class=\"line \"><span class=\"ln\">299</span><span class=\"code\">\t\texit:Reason:Stacktrace when Reason =/= normal, Reason =/= shutdown -&gt;</span></span>\n<span class=\"line \"><span class=\"ln\">300</span><span class=\"code\">\t\t\terlang:raise(exit, {Reason, Stacktrace}, Stacktrace)</span></span>\n</pre>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :cowboy_stream_h.request_process/3\n                            \n                            \n                                <span class=\"app right\">cowboy</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n                  <div class=\"frame-info\" data-index=\"14\" role=\"stack-trace-details\">\n                    <div class=\"file\">\n                        <a href=\"\">proc_lib.erl</a>\n                    </div>\n\n                    \n                    <div class=\"code code-block-empty\">No code available.</div>\n                    \n\n                    <div class=\"meta\">\n                        <div class=\"frame-mfa\">\n                            :proc_lib.init_p_do_apply/3\n                            \n                            \n                                <span class=\"app right\">stdlib</span>\n                            \n                        </div>\n                    </div>\n\n                    \n\n                    \n                </div>\n                \n            </div>\n\n            <div class=\"stack-trace\">\n                <div class=\"stack-trace-heading\">\n                    <label><input type=\"checkbox\" role=\"show-all-toggle\">Show only app frames</label>\n                </div>\n\n                <ul class=\"stack-trace-list -show-all\" role=\"stack-trace-list\">\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"0\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/live/page_live.ex<span class=\"line\">:14</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.PageLive.mount/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"1\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/utils.ex<span class=\"line\">:312</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">anonymous fn/4 in Phoenix.LiveView.Utils.maybe_call_live_view_mount!/4</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"2\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">telemetry</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/telemetry/src/telemetry.erl<span class=\"line\">:272</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:telemetry.span/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"3\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/static.ex<span class=\"line\">:302</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Static.call_mount_and_handle_params!/5</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"4\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/static.ex<span class=\"line\">:127</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Static.render/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"5\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix_live_view</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix_live_view/controller.ex<span class=\"line\">:35</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.LiveView.Controller.live_render/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"6\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix/router.ex<span class=\"line\">:352</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.Router.__call__/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"7\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/endpoint.ex<span class=\"line\">:1</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.plug_builder_call/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"8\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/plug/debugger.ex<span class=\"line\">:136</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.&quot;call (overridable 3)&quot;/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -app\" role=\"stack-trace-item\" data-index=\"9\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">web_app</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/web_app_web/endpoint.ex<span class=\"line\">:1</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">WebAppWeb.Endpoint.call/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"10\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">phoenix</span>\n                                \n\n                                <span class=\"filename\">\n                                    lib/phoenix/endpoint/cowboy2_handler.ex<span class=\"line\">:65</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">Phoenix.Endpoint.Cowboy2Handler.init/4</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"11\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_handler.erl<span class=\"line\">:37</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_handler.execute/2</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"12\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl<span class=\"line\">:306</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_stream_h.execute/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"13\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">cowboy</span>\n                                \n\n                                <span class=\"filename\">\n                                    /home/akoutmos/Documents/open_source/prom_ex/example_applications/web_app/deps/cowboy/src/cowboy_stream_h.erl<span class=\"line\">:295</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:cowboy_stream_h.request_process/3</span>\n                        </button>\n                    </li>\n                    \n                    <li>\n                        <button class=\"stack-trace-item -all\" role=\"stack-trace-item\" data-index=\"14\">\n                            <span class=\"left\">\n                                \n                                <span class=\"app\">stdlib</span>\n                                \n\n                                <span class=\"filename\">\n                                    proc_lib.erl<span class=\"line\">:226</span>\n                                </span>\n                            </span>\n\n                            <span class=\"info\">:proc_lib.init_p_do_apply/3</span>\n                        </button>\n                    </li>\n                    \n                </ul>\n            </div>\n        </div>\n    </div>\n\n    <div class=\"conn-info\">\n        \n\n        <details class=\"conn-details\">\n            <summary>Request info</summary>\n\n            <dl>\n                <dt>URI:</dt>\n                <dd class=\"code-quote\">http://localhost:4000/</dd>\n            </dl>\n\n            <dl>\n                <dt>Query string:</dt>\n                <dd class=\"code-quote\"></dd>\n            </dl>\n        </details>\n\n        <details class=\"conn-details\">\n            <summary>Headers</summary>\n            \n            <dl>\n                <dt>accept</dt>\n                <dd class=\"code-quote\">text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9</dd>\n            </dl>\n            \n            <dl>\n                <dt>accept-encoding</dt>\n                <dd class=\"code-quote\">gzip, deflate, br</dd>\n            </dl>\n            \n            <dl>\n                <dt>accept-language</dt>\n                <dd class=\"code-quote\">en-US,en;q=0.9</dd>\n            </dl>\n            \n            <dl>\n                <dt>cache-control</dt>\n                <dd class=\"code-quote\">no-cache</dd>\n            </dl>\n            \n            <dl>\n                <dt>connection</dt>\n                <dd class=\"code-quote\">keep-alive</dd>\n            </dl>\n            \n            <dl>\n                <dt>cookie</dt>\n                <dd class=\"code-quote\">_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik</dd>\n            </dl>\n            \n            <dl>\n                <dt>host</dt>\n                <dd class=\"code-quote\">localhost:4000</dd>\n            </dl>\n            \n            <dl>\n                <dt>pragma</dt>\n                <dd class=\"code-quote\">no-cache</dd>\n            </dl>\n            \n            <dl>\n                <dt>referer</dt>\n                <dd class=\"code-quote\">http://localhost:4000/</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-dest</dt>\n                <dd class=\"code-quote\">document</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-mode</dt>\n                <dd class=\"code-quote\">navigate</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-site</dt>\n                <dd class=\"code-quote\">same-origin</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-fetch-user</dt>\n                <dd class=\"code-quote\">?1</dd>\n            </dl>\n            \n            <dl>\n                <dt>sec-gpc</dt>\n                <dd class=\"code-quote\">1</dd>\n            </dl>\n            \n            <dl>\n                <dt>upgrade-insecure-requests</dt>\n                <dd class=\"code-quote\">1</dd>\n            </dl>\n            \n            <dl>\n                <dt>user-agent</dt>\n                <dd class=\"code-quote\">Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36</dd>\n            </dl>\n            \n        </details>\n\n        \n        <details class=\"conn-details\">\n            <summary>Session</summary>\n            \n            <dl>\n                <dt>_csrf_token</dt>\n                <dd><pre>&quot;626LE-xkix70s3s1wbOaTjJs&quot;</pre></dd>\n            </dl>\n            \n        </details>\n        \n    </div>\n\n    <script>(function () {\n        var $items = document.querySelectorAll('[role~=\"stack-trace-item\"]')\n        var $toggle = document.querySelector('[role~=\"show-all-toggle\"]')\n        var $list = document.querySelector('[role~=\"stack-trace-list\"]')\n\n        each($items, function ($item) {\n            on($item, 'click', itemOnclick)\n        })\n\n        on($toggle, 'click', toggleOnclick)\n\n        function toggleOnclick () {\n            if (this.checked) {\n                var $first = document.querySelector('[role~=\"stack-trace-item\"].-app:first-of-type')\n                if ($first) itemOnclick.call($first)\n                removeClass($list, '-show-all')\n            } else {\n                addClass($list, '-show-all')\n            }\n        }\n\n        function itemOnclick () {\n            var idx = this.getAttribute('data-index')\n\n            var $detail = document.querySelector('[role~=\"stack-trace-details\"].-active')\n            if ($detail) removeClass($detail, '-active')\n\n            $detail = document.querySelector('[role~=\"stack-trace-details\"][data-index=\"' + idx + '\"]')\n            if ($detail) addClass($detail, '-active')\n\n            var $item = document.querySelector('[role~=\"stack-trace-item\"].-active')\n            if ($item) removeClass($item, '-active')\n\n            $item = document.querySelector('[role~=\"stack-trace-item\"][data-index=\"' + idx + '\"]')\n            if ($item) addClass($item, '-active')\n        }\n\n        var $first = document.querySelector('[role~=\"stack-trace-item\"]:first-of-type')\n        if ($first) itemOnclick.call($first)\n\n        /*\n         * Helpers\n         */\n\n        function each (list, fn) {\n            for (var i = 0, len = list.length; i < len; i++) {\n                var item = list[i]\n                fn(item)\n            }\n        }\n\n        function addClass (el, className) {\n            if (el.classList) {\n                el.classList.add(className)\n            } else {\n                el.className += ' ' + className\n            }\n        }\n\n        function removeClass (el, className) {\n            if (el.classList) {\n                el.classList.remove(className)\n            } else {\n                var expr = new RegExp('(^|\\\\b)' + className.split(' ').join('|') + '(\\\\b|$)', 'gi')\n                el.className = el.className.replace(expr, ' ')\n            }\n        }\n\n        function on (el, event, handler) {\n            if (el.addEventListener) {\n                el.addEventListener(event, handler)\n            } else {\n                el.attachEvent('on' + event, function () {\n                    handler.call(el)\n                })\n            }\n        }\n    }())</script>\n</body>\n</html>\n",
        resp_cookies: %{},
        resp_headers: [
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8TBRRN164Xp8AACUS"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"content-type", "text/html; charset=utf-8"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 500
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 63890},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 52819},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "4",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 336_378_831},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "referer" => "http://localhost:4000/",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "same-origin",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45808},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 17,
             version: :"HTTP/1.1"
           }},
        assigns: %{
          content:
            {:safe,
             [
               60,
               "div",
               [
                 [32, "data-phx-main", 61, 34, "true", 34],
                 [
                   32,
                   "data-phx-session",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4VEZVMjZhMzVBd2NPZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCoz5LpeQFiAAFRgA.ZTBOX5G2gXhI508BH8ugG1DYjCXs7U3qkrevwz2_9Vo",
                   34
                 ],
                 [
                   32,
                   "data-phx-static",
                   61,
                   34,
                   "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4VEZVMjZhMzVBd2NPbgYAqM-S6XkBYgABUYA.dDAFO3rBgNmzUW8BmrKHLcrfgbOFUuQ_25_zTstiNrY",
                   34
                 ],
                 [32, "data-phx-view", 61, 34, "PageLive", 34],
                 [32, "id", 61, 34, "phx-FoZ8TFU26a35AwcO", 34]
               ],
               62,
               [
                 "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
                 "",
                 "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
                 "",
                 "</p>\n",
                 [
                   "<section class=\"phx-hero\">\n  <h1>",
                   "Welcome to Phoenix!",
                   "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                   "",
                   "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                   "",
                   "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
                 ],
                 "\n</main>\n"
               ],
               60,
               47,
               "div",
               62
             ]},
          flash: %{},
          layout: false,
          live_action: :index,
          live_module: WebAppWeb.PageLive,
          query: "",
          results: %{}
        },
        before_send: [],
        body_params: %{},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: [],
        path_params: %{},
        port: 4000,
        private: %{
          WebAppWeb.Router => {[], %{}},
          :phoenix_endpoint => WebAppWeb.Endpoint,
          :phoenix_flash => %{},
          :phoenix_format => "html",
          :phoenix_layout => false,
          :phoenix_live_view => {WebAppWeb.PageLive, [action: :index, router: WebAppWeb.Router]},
          :phoenix_request_logger => {"request_logger", "request_logger"},
          :phoenix_root_layout => {WebAppWeb.LayoutView, :root},
          :phoenix_router => WebAppWeb.Router,
          :phoenix_template => "template.html",
          :phoenix_view => Phoenix.LiveView.Static,
          :plug_session => %{"_csrf_token" => "626LE-xkix70s3s1wbOaTjJs"},
          :plug_session_fetch => :done
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"referer", "http://localhost:4000/"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "same-origin"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: [
          "<!DOCTYPE html>\n<html lang=\"en\">\n  <head>\n    <meta charset=\"utf-8\"/>\n    <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"/>\n",
          [
            60,
            "meta",
            [
              [32, "charset", 61, 34, "UTF-8", 34],
              [32, "content", 61, 34, "cgoOCANKIh8bCXpCK2IUVBkrECIaIi9HD88DFgZtrqMrXQgenI_CNHe4", 34],
              [32, "csrf-param", 61, 34, "_csrf_token", 34],
              [32, "method-param", 61, 34, "_method", 34],
              [32, "name", 61, 34, "csrf-token", 34]
            ],
            62
          ],
          "\n",
          [
            60,
            "title",
            [[32, "data-suffix", 61, 34, " · Phoenix Framework", 34]],
            62,
            "WebApp · Phoenix Framework",
            60,
            47,
            "title",
            62
          ],
          "\n    <link phx-track-static rel=\"stylesheet\" href=\"",
          "/css/app.css",
          "\"/>\n    <script defer phx-track-static type=\"text/javascript\" src=\"",
          "/js/app.js",
          "\"></script>\n  </head>\n  <body>\n    <header>\n      <section class=\"container\">\n        <nav role=\"navigation\">\n          <ul>\n            <li><a href=\"https://hexdocs.pm/phoenix/overview.html\">Get Started</a></li>\n",
          [
            "\n              <li>",
            [
              60,
              "a",
              [[32, "href", 61, 34, "/dashboard", 34]],
              62,
              "LiveDashboard",
              60,
              47,
              "a",
              62
            ],
            "</li>\n"
          ],
          "\n          </ul>\n        </nav>\n        <a href=\"https://phoenixframework.org/\" class=\"phx-logo\">\n          <img src=\"",
          "/images/phoenix.png",
          "\" alt=\"Phoenix Framework Logo\"/>\n        </a>\n      </section>\n    </header>\n",
          [
            60,
            "div",
            [
              [32, "data-phx-main", 61, 34, "true", 34],
              [
                32,
                "data-phx-session",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAAHZAACaWRtAAAAFHBoeC1Gb1o4VEZVMjZhMzVBd2NPZAAKcGFyZW50X3BpZGQAA25pbGQACHJvb3RfcGlkZAADbmlsZAAJcm9vdF92aWV3ZAAZRWxpeGlyLldlYkFwcFdlYi5QYWdlTGl2ZWQABnJvdXRlcmQAF0VsaXhpci5XZWJBcHBXZWIuUm91dGVyZAAHc2Vzc2lvbnQAAAAAZAAEdmlld2QAGUVsaXhpci5XZWJBcHBXZWIuUGFnZUxpdmVuBgCoz5LpeQFiAAFRgA.ZTBOX5G2gXhI508BH8ugG1DYjCXs7U3qkrevwz2_9Vo",
                34
              ],
              [
                32,
                "data-phx-static",
                61,
                34,
                "SFMyNTY.g2gDaAJhBHQAAAADZAAKYXNzaWduX25ld2pkAAVmbGFzaHQAAAAAZAACaWRtAAAAFHBoeC1Gb1o4VEZVMjZhMzVBd2NPbgYAqM-S6XkBYgABUYA.dDAFO3rBgNmzUW8BmrKHLcrfgbOFUuQ_25_zTstiNrY",
                34
              ],
              [32, "data-phx-view", 61, 34, "PageLive", 34],
              [32, "id", 61, 34, "phx-FoZ8TFU26a35AwcO", 34]
            ],
            62,
            [
              "<main role=\"main\" class=\"container\">\n  <p class=\"alert alert-info\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"info\">",
              "",
              "</p>\n\n  <p class=\"alert alert-danger\" role=\"alert\"\n    phx-click=\"lv:clear-flash\"\n    phx-value-key=\"error\">",
              "",
              "</p>\n",
              [
                "<section class=\"phx-hero\">\n  <h1>",
                "Welcome to Phoenix!",
                "</h1>\n  <p>Peace of mind from prototype to production</p>\n\n  <form phx-change=\"suggest\" phx-submit=\"search\">\n    <input type=\"text\" name=\"q\" value=\"",
                "",
                "\" placeholder=\"Live dependency search\" list=\"results\" autocomplete=\"off\"/>\n    <datalist id=\"results\">\n",
                "",
                "\n    </datalist>\n    <button type=\"submit\" phx-disable-with=\"Searching...\">Go to Hexdocs</button>\n  </form>\n</section>\n\n<section class=\"row\">\n  <article class=\"column\">\n    <h2>Resources</h2>\n    <ul>\n      <li>\n        <a href=\"https://hexdocs.pm/phoenix/overview.html\">Guides &amp; Docs</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix\">Source</a>\n      </li>\n      <li>\n        <a href=\"https://github.com/phoenixframework/phoenix/blob/v1.5/CHANGELOG.md\">v1.5 Changelog</a>\n      </li>\n    </ul>\n  </article>\n  <article class=\"column\">\n    <h2>Help</h2>\n    <ul>\n      <li>\n        <a href=\"https://elixirforum.com/c/phoenix-forum\">Forum</a>\n      </li>\n      <li>\n        <a href=\"https://webchat.freenode.net/?channels=elixir-lang\">#elixir-lang on Freenode IRC</a>\n      </li>\n      <li>\n        <a href=\"https://twitter.com/elixirphoenix\">Twitter @elixirphoenix</a>\n      </li>\n      <li>\n        <a href=\"https://elixir-slackin.herokuapp.com/\">Elixir on Slack</a>\n      </li>\n    </ul>\n  </article>\n</section>\n"
              ],
              "\n</main>\n"
            ],
            60,
            47,
            "div",
            62
          ],
          "\n  </body>\n</html>\n"
        ],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "text/html; charset=utf-8"},
          {"cache-control", "max-age=0, no-cache, no-store, must-revalidate, post-check=0, pre-check=0"},
          {"x-request-id", "FoZ8TFUm0TWA-QMAAAaO"},
          {"x-frame-options", "SAMEORIGIN"},
          {"x-xss-protection", "1; mode=block"},
          {"x-content-type-options", "nosniff"},
          {"x-download-options", "noopen"},
          {"x-permitted-cross-domain-policies", "none"},
          {"cross-origin-window-policy", "deny"},
          {"vary", "x-requested-with"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :channel_joined],
    measurements: %{duration: 66505},
    metadata: %{
      params: %{},
      result: :ok,
      socket: %{
        __struct__: Phoenix.Socket,
        assigns: %{},
        channel: Phoenix.LiveReloader.Channel,
        channel_pid: nil,
        endpoint: WebAppWeb.Endpoint,
        handler: Phoenix.LiveReloader.Socket,
        id: nil,
        join_ref: "3",
        joined: false,
        private: %{log_handle_in: :debug, log_join: :info},
        pubsub_server: WebApp.PubSub,
        ref: nil,
        serializer: Phoenix.Socket.V2.JSONSerializer,
        topic: "phoenix:live_reload",
        transport: :websocket,
        transport_pid: nil
      }
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 46467},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/another-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 11,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["another-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/another-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "5", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8TcUnpj_oAn8AAA2N"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 47489},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/another-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 12,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["another-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/another-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "5", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8Tf9pR1Wk79sAAAUM"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 66455},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/another-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 13,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["another-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/another-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "5", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8ThYDMObyPHsAAAgO"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 43582},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/another-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 14,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["another-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/another-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "5", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8TiknCIvE8ioAABMQ"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 42279},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/another-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 15,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["another-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/another-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "5", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8Tje-L8Lw-iEAAASK"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 45265},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/really-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 16,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["really-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/really-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T40t4JjGWf4AAEMB"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 40196},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/really-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 17,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["really-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/really-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T8Gph5_k9KwAABOQ"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 42600},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/really-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 18,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["really-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/really-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T9MhXL1nfEMAAAuF"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 40647},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/really-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 19,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["really-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/really-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T-HAeOTO8pMAAACG"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 46547},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "localhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "localhost",
             host_info: :undefined,
             method: "GET",
             path: "/really-cool-route",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 20,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "localhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: ["really-cool-route"],
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "localhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/really-cool-route",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T-7wK6JKr24AAAYP"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  },
  %{
    event: [:phoenix, :endpoint, :stop],
    measurements: %{duration: 335_366_105},
    metadata: %{
      conn: %{
        __struct__: Plug.Conn,
        adapter:
          {Plug.Cowboy.Conn,
           %{
             bindings: %{},
             body_length: 0,
             cert: :undefined,
             has_body: false,
             headers: %{
               "accept" =>
                 "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9",
               "accept-encoding" => "gzip, deflate, br",
               "accept-language" => "en-US,en;q=0.9",
               "cache-control" => "no-cache",
               "connection" => "keep-alive",
               "cookie" =>
                 "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik",
               "host" => "otherhost:4000",
               "pragma" => "no-cache",
               "sec-fetch-dest" => "document",
               "sec-fetch-mode" => "navigate",
               "sec-fetch-site" => "none",
               "sec-fetch-user" => "?1",
               "sec-gpc" => "1",
               "upgrade-insecure-requests" => "1",
               "user-agent" =>
                 "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
             },
             host: "otherhost",
             host_info: :undefined,
             method: "GET",
             path: "/",
             path_info: :undefined,
             peer: {{127, 0, 0, 1}, 45816},
             pid: nil,
             port: 4000,
             qs: "",
             ref: WebAppWeb.Endpoint.HTTP,
             scheme: "http",
             sock: {{127, 0, 0, 1}, 4000},
             streamid: 20,
             version: :"HTTP/1.1"
           }},
        assigns: %{},
        before_send: [],
        body_params: %{__struct__: Plug.Conn.Unfetched, aspect: :body_params},
        cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        halted: false,
        host: "otherhost",
        method: "GET",
        owner: nil,
        params: %{},
        path_info: :undefined,
        path_params: %{},
        port: 4000,
        private: %{
          phoenix_endpoint: WebAppWeb.Endpoint,
          phoenix_request_logger: {"request_logger", "request_logger"}
        },
        query_params: %{},
        query_string: "",
        remote_ip: {127, 0, 0, 1},
        req_cookies: %{
          "_web_app_key" =>
            "SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"
        },
        req_headers: [
          {"accept",
           "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9"},
          {"accept-encoding", "gzip, deflate, br"},
          {"accept-language", "en-US,en;q=0.9"},
          {"cache-control", "no-cache"},
          {"connection", "keep-alive"},
          {"cookie",
           "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYNjI2TEUteGtpeDcwczNzMXdiT2FUakpz.dv3_U0ixALpjrQ5DsBqexNfeQ2pPPH0v0WHUD6BU1Ik"},
          {"host", "otherhost:4000"},
          {"pragma", "no-cache"},
          {"sec-fetch-dest", "document"},
          {"sec-fetch-mode", "navigate"},
          {"sec-fetch-site", "none"},
          {"sec-fetch-user", "?1"},
          {"sec-gpc", "1"},
          {"upgrade-insecure-requests", "1"},
          {"user-agent",
           "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"}
        ],
        request_path: "/",
        resp_body: ["{\"", [[] | "a"], "\":", "10", 125],
        resp_cookies: %{},
        resp_headers: [
          {"content-type", "application/json; charset=utf-8"},
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"x-request-id", "FoZ8T-7wK6JKr24AAAYP"}
        ],
        scheme: :http,
        script_name: [],
        secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
        state: :set,
        status: 200
      },
      options: []
    }
  }
]
