defmodule WebApp.Repo2 do
  use Ecto.Repo,
    otp_app: :web_app,
    adapter: Ecto.Adapters.Postgres
end
