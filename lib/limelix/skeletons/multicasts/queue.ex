defmodule Limelix.Skeletons.Multicasts.Queue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Multicasts.Supervisor,
    registry: Limelix.Skeletons.Multicasts.Registry,
    crawler: Limelix.Skeletons.Multicasts.QoS
end
