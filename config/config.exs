# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kobayashi_maru,
  ecto_repos: [KobayashiMaru.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :kobayashi_maru, KobayashiMaruWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "zIkOWRE6gLKNZsWWHjg8LfoubvH7/olebB6bIM6+fGZWlm5RRIM7S50OB8NJhQ5i",
  render_errors: [view: KobayashiMaruWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: KobayashiMaru.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
