defmodule Limelix.Skeletons.Richmenus.ContentQueue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Richmenus.ContentSupervisor,
    registry: Limelix.Skeletons.Richmenus.ContentRegistry,
    crawler: Limelix.Skeletons.Richmenus.ContentQoS
end
