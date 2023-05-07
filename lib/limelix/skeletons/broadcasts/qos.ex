defmodule Limelix.Skeletons.Broadcasts.QoS do
  @moduledoc """
  # ブロードキャストメッセージを送る 60リクエスト/時
  https://developers.line.biz/ja/reference/messaging-api/#rate-limits
  """

  use Limelix.LINEQoS, max_request: 1, interval_ms: 60_000,
    endpoint: {Limelix.Skeletons.Broadcasts.Queue, :line_api}
end
