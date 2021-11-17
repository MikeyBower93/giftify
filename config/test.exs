import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :giftify, Giftify.Repo,
  username: "postgres",
  password: "postgres",
  database: "giftify_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :giftify, GiftifyWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "2kBggweWBuyyNUSGA2f4vgJ/GC/8XnY8cQtmZnFno3c1LmbdV5lbe4ca0dmt0gjj",
  server: false

# In test we don't send emails.
config :giftify, Giftify.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
