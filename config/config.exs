# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :kanban,
  ecto_repos: [Kanban.Repo]

# Configures the endpoint
config :kanban, KanbanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "N4bvfhPtp+21xgV3/WrT8YJozziQYHRlouWiRvcTms0hMXTcia8zHz2tBnlXkrrz",
  render_errors: [view: KanbanWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Kanban.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# need for compatibily front-end application
config :phoenix, :format_encoders, json: ProperCase.JSONEncoder.CamelCase

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
