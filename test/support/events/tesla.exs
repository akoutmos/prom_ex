[
  %{
    event: [:tesla, :request, :start],
    measurements: %{system_time: 1_654_972_577_479_492_414},
    metadata: %{
      env: %Tesla.Env{
        __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
        __module__: TestApp,
        body: nil,
        headers: [],
        method: :get,
        opts: [],
        query: [],
        status: nil,
        url: "/users"
      }
    }
  },
  %{
    event: [:tesla, :request, :stop],
    measurements: %{duration: 100_115_245},
    metadata: %{
      env: %Tesla.Env{
        __client__: %Tesla.Client{adapter: nil, fun: nil, post: [], pre: []},
        __module__: TestApp,
        body: [
          %{
            "age" => 46,
            "first_name" => "Frankie",
            "id" => "7cbd7a74-c09a-4d4d-a5b5-a9c25dab8ed3",
            "last_name" => "Price",
            "points" => 0
          },
          %{
            "age" => 26,
            "first_name" => "Matt",
            "id" => "0c4a8465-2731-4ecf-9c93-80bfe6d9eac7",
            "last_name" => "Hermann",
            "points" => 0
          }
        ],
        headers: [
          {"cache-control", "max-age=0, private, must-revalidate"},
          {"date", "Sat, 11 Jun 2022 18:36:16 GMT"},
          {"server", "Cowboy"},
          {"content-length", "109512"},
          {"content-type", "application/json; charset=utf-8"},
          {"x-request-id", "FvekynXlvJB0pCMAAAGC"}
        ],
        method: :get,
        opts: [],
        query: [],
        status: 200,
        url: "http://127.0.0.1:4000/users"
      }
    }
  }
]
