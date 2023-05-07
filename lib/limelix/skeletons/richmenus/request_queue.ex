defmodule Limelix.Skeletons.Richmenus.RequestQueue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Richmenus.RequestSupervisor,
    registry: Limelix.Skeletons.Richmenus.RequestRegistry,
    crawler: Limelix.Skeletons.Richmenus.RequestQoS
end
