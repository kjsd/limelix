defmodule Limelix.Skeletons.Narrowcasts do
  use Supervisor

  def start_link(_), do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)

  @impl true
  def init(_) do
    children = [
      {DynamicSupervisor,
       name: Limelix.Skeletons.Narrowcasts.AudienceSupervisor,
       strategy: :one_for_one},
      {Registry, keys: :unique,
       name: Limelix.Skeletons.Narrowcasts.AudienceRegistry},

      {DynamicSupervisor,
       name: Limelix.Skeletons.Narrowcasts.MessageSupervisor,
       strategy: :one_for_one},
      {Registry, keys: :unique,
       name: Limelix.Skeletons.Narrowcasts.MessageRegistry},

      {DynamicSupervisor,
       name: Limelix.Skeletons.Narrowcasts.RequestSupervisor,
       strategy: :one_for_one},
      {Registry, keys: :unique,
       name: Limelix.Skeletons.Narrowcasts.RequestRegistry}
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
