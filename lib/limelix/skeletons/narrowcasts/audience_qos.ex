defmodule Limelix.Skeletons.Narrowcasts.AudienceQoS do
  @moduledoc """
  # ユーザーIDアップロード用のオーディエンスを作成する（JSON指定） 60リクエスト/分
  # ...
  https://developers.line.biz/ja/reference/messaging-api/#rate-limits
  """

  use Limelix.LINESequentialQoS, max_request: 1, interval_ms: 1_000,
    endpoint: {Limelix.Skeletons.Narrowcasts.AudienceQueue, :line_api}
end
