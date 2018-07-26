use Mix.Config

config :postgres_auth, ecto_repos: [PostgresAuth.Repo]

config :postgres_auth, PostgresAuth.Guardian,
  issuer: "postgres_auth",
  secret_key: "/bVrD/kqdgYXm762e+RxR6lXPxSTQMYIWiJeehaNkL9s12hk9i7h8FHQkwRGKa/z"

if Mix.env() == :dev do
  config :mix_test_watch,
    setup_tasks: ["ecto.reset"],
    ansi_enabled: :ignore,
    clear: true
end

import_config "#{Mix.env()}.exs"
