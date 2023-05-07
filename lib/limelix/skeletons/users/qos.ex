defmodule Limelix.Skeletons.Users.QoS do
  @moduledoc """
  # 上記以外のエンドポイント	2,000リクエスト/秒
  https://developers.line.biz/ja/reference/messaging-api/#rate-limits
  """

  use Limelix.LINEQoS, max_request: 200, interval_ms: 100,
    endpoint: {Limelix.Skeletons.Users.Queue, :line_api}
end
