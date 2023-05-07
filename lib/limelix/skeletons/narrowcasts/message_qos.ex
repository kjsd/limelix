defmodule Limelix.Skeletons.Narrowcasts.MessageQoS do
  @moduledoc """
  # ナローキャストメッセージを送る 60リクエスト/時
  https://developers.line.biz/ja/reference/messaging-api/#rate-limits
  """

  use Limelix.LINEQoS, max_request: 1, interval_ms: 60_000,
    endpoint: {Limelix.Skeletons.Narrowcasts.MessageQueue, :line_api}
end
