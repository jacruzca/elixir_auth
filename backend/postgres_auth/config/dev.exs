use Mix.Config

config :postgres_auth, PostgresAuth.Repo, [
  adapter: Ecto.Adapters.Postgres,
  database: "postgres_auth_#{Mix.env}",
  username: "postgres",
  password: "",
  hostname: "localhost",
]