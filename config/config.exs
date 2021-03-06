# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vickrey,
  ecto_repos: [Vickrey.Repo]

# Configure your database
#config :vickrey, Vickrey.Repo,
#  username: "",
#  password: System.get_env("HANDSHAKE_DB_PW"),
#  database: "handshake",
#  hostname: #System.get_env("HANDSHAKE_DB_HOST"),
#  show_sensitive_data_on_connection_error: true,
#  pool_size: 10

# Configures the endpoint
config :vickrey, VickreyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Fb4fFA60FImLG5F6XPPzWPvCLJe5X5kdW0/c+Wb4T7X1jYgM/zU0LPCNV5bMqkCM",
  render_errors: [view: VickreyWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Vickrey.PubSub,
  live_view: [signing_salt: "9PXABSvR"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Handshake auth
config :vickrey,
  ip: System.get_env("HANDSHAKE_NODE"),
  port: System.get_env("HANDSHAKE_NODE_PORT"),
  node_api_key: System.get_env("HANDSHAKE_API_KEY"),
  wallet_api_key: ""

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
