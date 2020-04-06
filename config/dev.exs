use Mix.Config

# Configure your database
config :phoenix_starter, PhoenixStarter.Repo,
  username: "postgres",
  password: "postgres",
  database: "phoenix_starter_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with webpack to recompile .js and .css sources.
config :phoenix_starter, PhoenixStarterWeb.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [
    node: [
      "server.dev.js"
    ]
  ]

config :phoenix_starter, PhoenixStarterWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/gettext/.*(po)$",
      ~r"lib/phoenix_starter_web/(live|views)/.*(ex)$",
      ~r"lib/phoenix_starter_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
