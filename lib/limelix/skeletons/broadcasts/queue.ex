defmodule Limelix.Skeletons.Broadcasts.Queue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Broadcasts.Supervisor,
    registry: Limelix.Skeletons.Broadcasts.Registry,
    crawler: Limelix.Skeletons.Broadcasts.QoS
end
