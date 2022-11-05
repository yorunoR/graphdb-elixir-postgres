import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :server, Server.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "+g2FuxEmK/46dHJGtOutsGsg+x9fUYe7oFtYi8iIpxXxFrpb8LCUccOQZnNPyMhJ",
  server: false
