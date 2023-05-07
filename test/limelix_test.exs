defmodule LimelixTest do
  use ExUnit.Case
  @moduletag :limelix
  @moduletag timeout: :infinity
  doctest Limelix

  describe "Limelix queue helpers" do
    test "reply/4" do
      assert res =  Limelix.reply("TOKEN", "REPLYTOKEN", [%{}])

      assert match?({:ok, _}, res)
    end

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

    test "progress_narrowcast/3" do
      assert res =  Limelix.progress_narrowcast("TOKEN", "REQUEST_ID")

      assert match?({:ok, _}, res)
    end

    test "create_audience/4" do
      assert res =  Limelix.create_audience("TOKEN", "DESC", ["UID"])

      assert match?({:ok, _}, res)
    end

    test "merge_audience/5" do
      assert res =  Limelix.merge_audience("TOKEN", 999, "DESC", ["UID"])

      assert match?({:ok, _}, res)
    end

    test "delete_audience/3" do
      assert res =  Limelix.delete_audience("TOKEN", 999)

      assert match?({:ok, _}, res)
    end

    test "create_richmenu/3" do
      assert res =  Limelix.create_richmenu("TOKEN", %{}, "http://httpbin.org/status/200")

      assert match?({:ok, _}, res)
    end

    test "delete_richmenu/3" do
      assert res =  Limelix.delete_richmenu("TOKEN", "RICHMENUID")

      assert match?({:ok, _}, res)
    end

    test "get_richmenu/3" do
      assert res =  Limelix.get_richmenu("TOKEN", "RICHMENUID")

      assert match?({:ok, _}, res)
    end

    test "alias_richmenu/4" do
      assert res =  Limelix.alias_richmenu("TOKEN", "RICHMENUID", "ALIASID")

      assert match?({:ok, _}, res)
    end

    test "unalias_richmenu/3" do
      assert res =  Limelix.unalias_richmenu("TOKEN", "ALIASID")

      assert match?({:ok, _}, res)
    end

    test "link_richmenu/4" do
      assert res =  Limelix.link_richmenu("TOKEN", "RICHMENUID", ["UID"])

      assert match?({:ok, _}, res)
    end

    test "unlink_richmenu/4" do
      assert res =  Limelix.unlink_richmenu("TOKEN", ["UID"])

      assert match?({:ok, _}, res)
    end

    test "get_profile/3" do
      assert res =  Limelix.get_profile("TOKEN", "UID")

      assert match?({:ok, _}, res)
    end
  end
end
