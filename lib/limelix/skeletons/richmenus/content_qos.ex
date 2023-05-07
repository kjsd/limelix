defmodule Limelix.Skeletons.Richmenus.ContentQoS do
  @moduledoc """
  # リッチメニューを作成する 100リクエスト/時 ※
  # リッチメニューを削除する 100リクエスト/時 ※
  # リッチメニューエイリアスを削除する 100リクエスト/時 ※
  https://developers.line.biz/ja/reference/messaging-api/#rate-limits
  """

  # Allow Request/36sec (available retry when errors)
  use Limelix.LINESequentialQoS, max_request: 1, interval_ms: 12_000,
    endpoint: {Limelix.Skeletons.Richmenus.ContentQueue, :content_richmenu}
end
