defmodule Limelix.Skeletons.Narrowcasts.MessageQueue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Narrowcasts.MessageSupervisor,
    registry: Limelix.Skeletons.Narrowcasts.MessageRegistry,
    crawler: Limelix.Skeletons.Narrowcasts.MessageQoS
end
