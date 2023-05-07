defmodule Limelix.SkeletonsTest do
  use ExUnit.Case
  @moduletag :limelix
  @moduletag timeout: :infinity
  @moduledoc """
  QoS rating tests
  """

  @endpoint {:get_profile!, ["token", "uid"]}

  alias Limelix.Skeletons.Pushes

  describe "Pushes" do
    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Pushes.Queue.enqueue("key", {nil, @endpoint})
      end)

      :timer.sleep(100)
      assert match?([_|_], Pushes.Queue.queue("key"))
      :timer.sleep(1000)
      assert 2000 > Pushes.Queue.queue("key") |> Enum.count
    end
  end

  alias Limelix.Skeletons.Multicasts

  describe "Multicasts" do
    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Multicasts.Queue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Multicasts.Queue.queue("key"))
      :timer.sleep(1000)
      assert 2000 > Multicasts.Queue.queue("key") |> Enum.count
    end
  end

  alias Limelix.Skeletons.Narrowcasts

  describe "Narrowcasts" do
    test "ユーザーIDアップロード用のオーディエンスを作成する（JSON指定） 60リクエスト/分" do
      Enum.each(1..1, fn _ ->
        Narrowcasts.AudienceQueue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Narrowcasts.AudienceQueue.queue("key"))
      :timer.sleep(3000)
      assert [] == Narrowcasts.AudienceQueue.queue("key")
    end

    test "ナローキャストメッセージを送る 60リクエスト/時" do
      Enum.each(1..1, fn _ ->
        Narrowcasts.MessageQueue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(1000)
      assert match?([_|_], Narrowcasts.MessageQueue.queue("key"))
      :timer.sleep(60_000)
      assert [] == Narrowcasts.MessageQueue.queue("key")
    end

    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Narrowcasts.RequestQueue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Narrowcasts.RequestQueue.queue("key"))
      :timer.sleep(1000)
      assert 2000 > Narrowcasts.RequestQueue.queue("key") |> Enum.count
    end
  end

  alias Limelix.Skeletons.Broadcasts
  
  describe "Broadcasts" do
    test "ブロードキャストメッセージを送る 60リクエスト/時" do
      Enum.each(1..1, fn _ ->
        Broadcasts.Queue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Broadcasts.Queue.queue("key"))
      :timer.sleep(60_000)
      assert [] == Broadcasts.Queue.queue("key")
    end
  end

  alias Limelix.Skeletons.Replies

  describe "Replies" do
    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Replies.Queue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Replies.Queue.queue("key"))
      :timer.sleep(1000)
      assert 2000 > Replies.Queue.queue("key") |> Enum.count
    end
  end

  alias Limelix.Skeletons.Users

  describe "Users" do
    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Users.Queue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Users.Queue.queue("key"))
      :timer.sleep(1000)
      assert 2000 >Users.Queue.queue("key") |> Enum.count
    end
  end

  alias Limelix.Skeletons.Richmenus

  describe "Richmenus" do
    test "リッチメニューを作成する 100リクエスト/時" do
      Enum.each(1..1, fn _ ->
        Richmenus.ContentQueue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(1000)
      assert match?([_|_], Richmenus.ContentQueue.queue("key"))
      :timer.sleep(36_000)
      assert [] == Richmenus.ContentQueue.queue("key")
    end

    test "上記以外のエンドポイント	2,000リクエスト/秒" do
      Enum.each(1..2000, fn _ ->
        Richmenus.RequestQueue.enqueue("key", {nil, @endpoint})
      end)
      
      :timer.sleep(100)
      assert match?([_|_], Richmenus.RequestQueue.queue("key"))
      :timer.sleep(1000)
      assert 2000 > Richmenus.RequestQueue.queue("key") |> Enum.count
    end
  end
end
