import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :metro_cdmx_api, MetroCdmxApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "metro_cdmx_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :metro_cdmx_api, MetroCdmxApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "xfI3yWArlOYIpt6cz9WrHaznTRqZOB63cpieIOKwoDL98SgGQjz9lPy6nPnzn94v",
  server: false

# In test we don't send emails.
config :metro_cdmx_api, MetroCdmxApi.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
