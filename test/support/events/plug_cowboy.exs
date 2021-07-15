[
  %{
    event: [:cowboy, :request, :stop],
    measurements: %{
      duration: 53504000,
      req_body_duration: 0,
      req_body_length: 0,
      resp_body_length: 0,
      resp_duration: 0
    },
    metadata: %{
      pid: nil,
      ref: WebAppWeb.Endpoint.HTTP,
      req: %{
        body_length: 0,
        cert: :undefined,
        has_body: false,
        headers: %{
          "accept-encoding" => "gzip, deflate, br",
          "accept-language" => "en-US",
          "cache-control" => "no-cache",
          "connection" => "Upgrade",
          "host" => "localhost:4000",
          "pragma" => "no-cache",
          "sec-websocket-extensions" => "permessage-deflate; client_max_window_bits",
          "sec-websocket-key" => "RiBYBD0m+Q2Jg7mpcCR72g==",
          "sec-websocket-version" => "13",
          "upgrade" => "websocket",
          "user-agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_0) AppleWebKit/537.36 (KHTML, like Gecko) Insomnia/2021.4.1 Chrome/83.0.4103.122 Electron/9.3.5 Safari/537.36"
        },
        host: "localhost",
        method: "GET",
        path: "/phoenix/live_reload/socket/websocket",
        peer: {{127, 0, 0, 1}, 54817},
        pid: nil,
        port: 4000,
        qs: "vsn=2.0.0",
        ref: WebAppWeb.Endpoint.HTTP,
        scheme: "http",
        sock: {{127, 0, 0, 1}, 4000},
        streamid: 1,
        version: :"HTTP/1.1"
      },
      resp_headers: :undefined,
      resp_status: :undefined,
      streamid: 1
    }
  },
  %{
    event: [:cowboy, :request, :stop],
    measurements: %{
      duration: 117251000,
      req_body_duration: 0,
      req_body_length: 0,
      resp_body_length: 359413,
      resp_duration: 0
    },
    metadata: %{
      pid: nil,
      ref: WebAppWeb.Endpoint.HTTP,
      req: %{
        body_length: 0,
        cert: :undefined,
        has_body: false,
        headers: %{
          "accept" => "*/*",
          "cookie" => "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYUU1ZRWVGaE9SMnpXSG1tczlfVDRCRm95.nXW-mcHRFi2qAJ7XlcyA-uf6IKyNi7ZmNQSSetrFQjM",
          "host" => "localhost:4000",
          "user-agent" => "insomnia/2021.4.1"
        },
        host: "localhost",
        method: "GET",
        path: "/events",
        peer: {{127, 0, 0, 1}, 54836},
        pid: nil,
        port: 4000,
        qs: "",
        ref: WebAppWeb.Endpoint.HTTP,
        scheme: "http",
        sock: {{127, 0, 0, 1}, 4000},
        streamid: 1,
        version: :"HTTP/1.1"
      },
      resp_headers: %{
        "cache-control" => "max-age=0, private, must-revalidate",
        "content-length" => "359413",
        "content-type" => "text/plain; charset=utf-8",
        "date" => "Thu, 15 Jul 2021 15:18:29 GMT",
        "server" => "Cowboy",
        "x-request-id" => "FpH_55ka2vBxMPwAAO7C"
      },
      resp_status: "200 OK",
      streamid: 1
    }
  },
  %{
    event: [:cowboy, :request, :stop],
    measurements: %{
      duration: 711000,
      req_body_duration: 0,
      req_body_length: 0,
      resp_body_length: 13900,
      resp_duration: 0
    },
    metadata: %{
      pid: nil,
      ref: WebAppWeb.Endpoint.HTTP,
      req: %{
        body_length: 0,
        cert: :undefined,
        has_body: false,
        headers: %{
          "accept" => "image/webp,image/apng,image/*,*/*;q=0.8",
          "accept-encoding" => "gzip, deflate, br",
          "accept-language" => "en-US",
          "connection" => "keep-alive",
          "host" => "localhost:4000",
          "sec-fetch-dest" => "image",
          "sec-fetch-mode" => "no-cors",
          "sec-fetch-site" => "cross-site",
          "user-agent" => "Mozilla/5.0 (Macintosh; Intel Mac OS X 11_0_0) AppleWebKit/537.36 (KHTML, like Gecko) Insomnia/2021.4.1 Chrome/83.0.4103.122 Electron/9.3.5 Safari/537.36"
        },
        host: "localhost",
        method: "GET",
        path: "/images/phoenix.png",
        peer: {{127, 0, 0, 1}, 54815},
        pid: nil,
        port: 4000,
        qs: "",
        ref: WebAppWeb.Endpoint.HTTP,
        scheme: "http",
        sock: {{127, 0, 0, 1}, 4000},
        streamid: 1,
        version: :"HTTP/1.1"
      },
      resp_headers: %{
        "accept-ranges" => "bytes",
        "cache-control" => "public",
        "content-length" => "13900",
        "content-type" => "image/png",
        "date" => "Thu, 15 Jul 2021 15:17:20 GMT",
        "etag" => "\"625F266\"",
        "server" => "Cowboy"
      },
      resp_status: 200,
      streamid: 1
    }
  },
  %{
    event: [:cowboy, :request, :stop],
    measurements: %{
      duration: 19834000,
      req_body_duration: 0,
      req_body_length: 0,
      resp_body_length: 189726,
      resp_duration: 0
    },
    metadata: %{
      pid: nil,
      ref: WebAppWeb.Endpoint.HTTP,
      req: %{
        body_length: 0,
        cert: :undefined,
        has_body: false,
        headers: %{
          "accept" => "*/*",
          "cookie" => "_web_app_key=SFMyNTY.g3QAAAABbQAAAAtfY3NyZl90b2tlbm0AAAAYUU1ZRWVGaE9SMnpXSG1tczlfVDRCRm95.nXW-mcHRFi2qAJ7XlcyA-uf6IKyNi7ZmNQSSetrFQjM",
          "host" => "localhost:4000",
          "user-agent" => "insomnia/2021.4.1"
        },
        host: "localhost",
        method: "GET",
        path: "/metrics",
        peer: {{127, 0, 0, 1}, 54870},
        pid: nil,
        port: 4000,
        qs: "",
        ref: WebAppWeb.Endpoint.HTTP,
        scheme: "http",
        sock: {{127, 0, 0, 1}, 4000},
        streamid: 1,
        version: :"HTTP/1.1"
      },
      resp_headers: %{
        "cache-control" => "max-age=0, private, must-revalidate",
        "content-length" => "189726",
        "content-type" => "text/plain; charset=utf-8",
        "date" => "Thu, 15 Jul 2021 15:20:46 GMT",
        "server" => "Cowboy"
      },
      resp_status: "200 OK",
      streamid: 1
    }
  }
]
