defmodule Limelix.Skeletons.Pushes.Queue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Pushes.Supervisor,
    registry: Limelix.Skeletons.Pushes.Registry,
    crawler: Limelix.Skeletons.Pushes.QoS
end
