defmodule Limelix.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Limelix.Skeletons.Users,
      Limelix.Skeletons.Replies,
      Limelix.Skeletons.Pushes,
      Limelix.Skeletons.Multicasts,
      Limelix.Skeletons.Broadcasts,
      Limelix.Skeletons.Narrowcasts,
      Limelix.Skeletons.Richmenus,
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Limelix.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
