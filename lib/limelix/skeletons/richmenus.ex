defmodule Limelix.Skeletons.Richmenus do
  use Supervisor

  def start_link(_), do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)

  @impl true
  def init(_) do
    children = [
      {DynamicSupervisor,
       name: Limelix.Skeletons.Richmenus.ContentSupervisor, strategy: :one_for_one},
      {Registry, keys: :unique,
       name: Limelix.Skeletons.Richmenus.ContentRegistry},

      {DynamicSupervisor,
       name: Limelix.Skeletons.Richmenus.RequestSupervisor, strategy: :one_for_one},
      {Registry, keys: :unique,
       name: Limelix.Skeletons.Richmenus.RequestRegistry}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
