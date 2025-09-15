[
  %{
    event: [:finch, :request, :start],
    measurements: %{system_time: 1_613_452_097_376_417_400},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443}
    }
  },
  %{
    event: [:finch, :request, :stop],
    measurements: %{duration: 150_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443},
      result: {:ok, %{status: 200}}
    }
  },
  %{
    event: [:finch, :request, :stop],
    measurements: %{duration: 200_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :post, scheme: :https, host: "api.example.com", port: 443},
      result: {:ok, %{status: 201}}
    }
  },
  %{
    event: [:finch, :request, :exception],
    measurements: %{duration: 50_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :post, scheme: :https, host: "api.example.com", port: 443},
      kind: :error,
      reason: :timeout,
      stacktrace: []
    }
  },
  %{
    event: [:finch, :queue, :start],
    measurements: %{system_time: 1_613_452_097_376_417_400},
    metadata: %{
      name: MyApp.Finch,
      pool: {:https, "api.example.com", 443},
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443}
    }
  },
  %{
    event: [:finch, :queue, :stop],
    measurements: %{duration: 5_000_000, idle_time: 10_000_000},
    metadata: %{
      name: MyApp.Finch,
      pool: {:https, "api.example.com", 443},
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443}
    }
  },
  %{
    event: [:finch, :queue, :exception],
    measurements: %{duration: 1_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443},
      kind: :error,
      reason: :pool_timeout,
      stacktrace: []
    }
  },
  %{
    event: [:finch, :connect, :start],
    measurements: %{system_time: 1_613_452_097_376_417_400},
    metadata: %{
      name: MyApp.Finch,
      scheme: :https,
      host: "api.example.com",
      port: 443
    }
  },
  %{
    event: [:finch, :connect, :stop],
    measurements: %{duration: 25_000_000},
    metadata: %{
      name: MyApp.Finch,
      scheme: :https,
      host: "api.example.com",
      port: 443,
      error: nil
    }
  },
  %{
    event: [:finch, :send, :start],
    measurements: %{system_time: 1_613_452_097_376_417_400, idle_time: 5_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443}
    }
  },
  %{
    event: [:finch, :send, :stop],
    measurements: %{duration: 75_000_000, idle_time: 5_000_000},
    metadata: %{
      name: MyApp.Finch,
      request: %{method: :get, scheme: :https, host: "api.example.com", port: 443},
      error: nil
    }
  }
]