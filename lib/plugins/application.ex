defmodule PromEx.Plugins.Application do
  # Get the versions of all the applications:
  # - Application.started_applications() |> Enum.map(fn {app, _, version} -> {app, :erlang.iolist_to_binary(version)} end)
  # - Mix.Project.deps_apps() |> Enum.map(fn app -> {app, Application.spec(app, :vsn) |> :erlang.iolist_to_binary()} end)
  # Also include GIT SHA and highlight application version
end
