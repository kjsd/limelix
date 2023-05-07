defmodule Limelix.Skeletons.Multicasts do
  use Supervisor

  def start_link(_), do: Supervisor.start_link(__MODULE__, [], name: __MODULE__)

  @impl true
  def init(_) do
    children = [
      {DynamicSupervisor, name: Limelix.Skeletons.Multicasts.Supervisor,
       strategy: :one_for_one},
      {Registry, keys: :unique, name: Limelix.Skeletons.Multicasts.Registry},
    ]

    Supervisor.init(children, strategy: :one_for_all)
  end
end
