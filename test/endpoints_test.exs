defmodule Limelix.EndpointsTest do
  use ExUnit.Case
  @moduletag :limelix
  doctest Limelix.Endpoints

  alias Limelix.Endpoints

  describe "content_richmenu/1" do
    test "create_richmenu!" do
      res = Endpoints.content_richmenu({
        :create_richmenu!, ["token", %{aaa: 1}, "http://httpbin.org/status/200"]})

      assert match?({:ok, {200, %{"richMenuId" => _}, []}}, res)
    end
    test "else" do
      res = Endpoints.content_richmenu({:delete_richmenu!, [
                                             "token", "richmenu-id"]})

      assert match?({:ok, {200, _, _}}, res)
    end
  end

  describe "create_richmenu/3" do
    test "normal" do
      res = Endpoints.create_richmenu(
        "token", %{aaa: 1}, "http://httpbin.org/status/200")

      assert match?({:ok, {200, %{"richMenuId" => _}, []}}, res)
    end
  end

  describe "line_api/1" do
    test "normal" do
      res = Endpoints.line_api({:push!, ["token", "uid", [%{aaa: 1}]]})

      assert match?({:ok, {200, _, _}}, res)
    end
  end
end
