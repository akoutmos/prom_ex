defmodule PromEx.Plugins.EctoTest do
  use ExUnit.Case, async: true

  alias PromEx.Plugins.Ecto
  alias PromEx.Test.Support.{Events, Metrics}

  defmodule WebApp.PromEx do
    use PromEx, otp_app: :web_app

    @impl true
    def plugins do
      [{Ecto, repos: [WebApp.Repo]}]
    end
  end

  test "telemetry events are accumulated" do
    Application.put_env(:web_app, :ecto_repos, [WebApp.Repo])
    Application.put_env(:web_app, WebApp.Repo, [])
    start_supervised!(WebApp.PromEx)
    Events.execute_all(:ecto)

    Metrics.assert_prom_ex_metrics(WebApp.PromEx, :ecto)
  end
end
