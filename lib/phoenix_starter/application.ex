defmodule PhoenixStarter.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      PhoenixStarter.Repo,
      PhoenixStarterWeb.Endpoint,
      {Phoenix.PubSub,
       [name: PhoenixStarter.PubSub, adapter: Phoenix.PubSub.PG2]}
    ]

    opts = [strategy: :one_for_one, name: PhoenixStarter.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PhoenixStarterWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
