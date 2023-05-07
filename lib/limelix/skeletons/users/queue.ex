defmodule Limelix.Skeletons.Users.Queue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Users.Supervisor,
    registry: Limelix.Skeletons.Users.Registry,
    crawler: Limelix.Skeletons.Users.QoS
end
