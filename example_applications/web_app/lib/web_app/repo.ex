defmodule WebApp.Repo do
  use Ecto.Repo,
    otp_app: :web_app,
    adapter: Ecto.Adapters.Postgres
end
