use Mix.Config

config :grpc, start_server: true

config :database,
  ecto_repos: [Database.Repo]

import_config "#{Mix.env()}.exs"
