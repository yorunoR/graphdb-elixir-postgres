import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :u7406, U7406.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "u7406_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :server, Server.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+g2FuxEmK/46dHJGtOutsGsg+x9fUYe7oFtYi8iIpxXxFrpb8LCUccOQZnNPyMhJ",
  server: false
