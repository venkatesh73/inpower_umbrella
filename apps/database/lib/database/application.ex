defmodule Database.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Database.Repo,
      {GRPC.Server.Supervisor, {Database.Endpoint, 8080}}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Database.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
