defmodule Limelix.Skeletons.Narrowcasts.AudienceQueue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Narrowcasts.AudienceSupervisor,
    registry: Limelix.Skeletons.Narrowcasts.AudienceRegistry,
    crawler: Limelix.Skeletons.Narrowcasts.AudienceQoS
end
