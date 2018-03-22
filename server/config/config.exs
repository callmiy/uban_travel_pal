# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :urban,
  ecto_repos: [Urban.Repo]

# Configures the endpoint
config :urban, UrbanWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "0i/vf1U4poA4qnHVjYx6enj41fBptN/rrUuUjp7I6aIRKeGpzSjG/+YPZ4lb0M7R",
  render_errors: [view: UrbanWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: Urban.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"