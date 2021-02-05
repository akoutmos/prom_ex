import Config

if Mix.env() != :prod do
  config :git_hooks,
    auto_install: true,
    verbose: true,
    hooks: [
      pre_commit: [
        tasks: [
          {:cmd, "mix format --check-formatted"},
          {:cmd, "mix compile --warnings-as-errors"},
          {:cmd, "mix credo --strict"},
          {:cmd, "mix doctor"},
          {:cmd, "mix dialyzer"},
          {:cmd, "mix test"}
        ]
      ]
    ]
end
