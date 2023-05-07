defmodule Limelix.Skeletons.Replies.Queue do
  use Rpcsdk.Queue,
    supervisor: Limelix.Skeletons.Replies.Supervisor,
    registry: Limelix.Skeletons.Replies.Registry,
    crawler: Limelix.Skeletons.Replies.Qos
end
