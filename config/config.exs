# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pyrex,
  namespace: PYREx,
  ecto_repos: [PYREx.Repo.Local]

# Configures the endpoint
config :pyrex, PYRExWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PYRExWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: PYREx.PubSub,
  live_view: [signing_salt: "YOoKQgxg"]

config :pyrex, PYREx.Repo.Local,
  priv: "priv/repo",
  extensions: [{Geo.PostGIS.Extension, library: Geo}],
  adapter: Ecto.Adapters.Postgres,
  types: PYREx.PostgrexTypes,
  queue_target: 1_000,
  queue_interval: 10_000

# Configures Plug.BasicAuth for viewing the live dashboard
config :pyrex, :basic_auth,
  username: "username",
  password: "password"

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configure tailwind
config :tailwind,
  version: "3.1.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
