defmodule Limelix.Skeletons.Narrowcasts.RequestQueue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Narrowcasts.RequestSupervisor,
    registry: Limelix.Skeletons.Narrowcasts.RequestRegistry,
    crawler: Limelix.Skeletons.Narrowcasts.RequestQoS
end
