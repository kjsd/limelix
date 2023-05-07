defmodule Limelix.LINEQoSTest do
  use ExUnit.Case
  @moduletag :limelix

  alias Limelix.Skeletons.Users.Queue, as: DummyQueue
  use Limelix.LINEQoS, max_request: 100, interval_ms: 100,
    endpoint: {DummyQueue, :echo}

  describe "handle_crawling/3" do
    test "normal" do
      assert :ok == handle_crawling({self(), "test"}, "key", {10_000, {1, 0}})

      receive do
        "test" ->
          assert true
        _ ->
          assert false
      end
    end
  end

  describe "handle_crawled/3" do
    test "normal" do
      res = handle_crawled([:ok], nil, {10_000, {1, 0}})

      assert match?({_, {_, _}}, res)
    end
  end
end
