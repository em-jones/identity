# Note: This file is for testing configuration only.
import Config

config :identity, Identity.Notifier.Swoosh,
  from: "test@example.com",
  mailer: Identity.Test.SwooshMailer

config :identity, Identity.Test.Endpoint,
  check_origin: false,
  code_reloader: false,
  debug_errors: true,
  http: [port: 4000],
  pubsub_server: Identity.Test.PubSub,
  secret_key_base: :binary.copy("secret", 12),
  server: true,
  url: [host: "localhost"]

config :identity, Identity.Test.SwooshMailer, adapter: Swoosh.Adapters.Test

config :identity, Identity.Test.Repo,
  name: Identity.Test.Repo,
  priv: "test/support/",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "postgres",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

config :identity,
  ecto_repos: [Identity.Test.Repo],
  notifier: Identity.Notifier.Test,
  repo: Identity.Test.Repo,
  user: Identity.Test.User

config :ueberauth, Ueberauth, providers: []
