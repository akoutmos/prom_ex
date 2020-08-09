# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :web_app,
  ecto_repos: [WebApp.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :web_app, WebAppWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "5fBSdz+TtF5BpvdQA4BVXsADOz4AUIrUeUPDy4CUpZb37kCLgrLT0Tfhq7fBT5TC",
  render_errors: [view: WebAppWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: WebApp.PubSub,
  live_view: [signing_salt: "6mGOJvNQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
