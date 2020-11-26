unless Code.ensure_loaded?(Ecto) do
  raise "Attempting to use PromEx Ecto plugin when Ecto has not been installed"
end

defmodule PromEx.Plugins.Ecto do
  @moduledoc """
  This plugin captures metrics emitted by Ecto.

  This plugin supports the following options:
  - `repo`: This is a REQUIRED option and is the full module name of your Ecto Repo (e.g MyApp.Repo).

  - `otp_app`: This is a REQUIRED option and is the name of you application in snake case (e.g. :my_cool_app).


  This plugin exposes the following metric groups:
  - `:`

  To use plugin in your application, add the following to your PromEx module `plugins/0` function:
  ```
  def plugins do
    [
      ...

      {PromEx.Plugins.Ecto, otp_app: :web_app, repo: WebApp.Repo}
    ]
  end

  ```
  """

  use PromEx.Plugin

  require Logger

  @impl true
  def event_metrics(opts) do
    repo = Keyword.fetch!(opts, :repo)
    otp_app = Keyword.fetch!(opts, :otp_app)

    _telemetry_prefix =
      otp_app
      |> Application.get_env(repo)
      |> Keyword.get_lazy(:telemetry_prefix, fn ->
        telemetry_prefix(repo)
      end)

    # Event metrics definitions
    Event.build(
      :ecto_query_event_metrics,
      []
    )
  end

  # Generate the default telemetry prefix
  defp telemetry_prefix(repo) do
    repo
    |> Module.split()
    |> Enum.map(&(&1 |> Macro.underscore() |> String.to_atom()))
  end
end
