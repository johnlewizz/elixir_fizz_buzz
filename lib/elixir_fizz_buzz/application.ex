defmodule ElixirFizzBuzz.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ElixirFizzBuzzWeb.Telemetry,
      ElixirFizzBuzz.Repo,
      {Phoenix.PubSub, name: ElixirFizzBuzz.PubSub},
      {Finch, name: ElixirFizzBuzz.Finch},
      ElixirFizzBuzzWeb.Endpoint,
      FizzBuzz.FavouritesCache

    ]
    opts = [strategy: :one_for_one, name: ElixirFizzBuzz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    ElixirFizzBuzzWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
