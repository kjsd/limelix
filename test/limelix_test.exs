defmodule LimelixTest do
  use ExUnit.Case
  @moduletag :limelix
  @moduletag timeout: :infinity
  doctest Limelix

  describe "Limelix queue helpers" do
    test "push/5" do
      assert res =  Limelix.push("TOKEN", "UID", [%{}])

      assert match?({:ok, _}, res)
    end

    test "multicast/5" do
      assert res =  Limelix.multicast("TOKEN", ["UID"], [%{}])

      assert match?({:ok, _}, res)
    end

    test "broadcast/4" do
      assert res =  Limelix.broadcast("TOKEN", [%{}])

      assert match?({:ok, _}, res)
    end

    test "narrowcast/6" do
      assert res =  Limelix.narrowcast("TOKEN", [%{}], %{}, %{}, %{})

      assert match?({:ok, _}, res)
    end
  end
end
