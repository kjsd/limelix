defmodule Limelix do
  @moduledoc """
  Helpers
  """

  alias Limelix.Skeletons.Pushes
  alias Limelix.Skeletons.Multicasts
  alias Limelix.Skeletons.Narrowcasts
  alias Limelix.Skeletons.Broadcasts
  alias Limelix.Skeletons.Replies
  alias Limelix.Skeletons.Users
  alias Limelix.Skeletons.Richmenus

  def push(access_token, to, [_|_] = messages, options \\ [],
    oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(to) and is_list(options) do
    Pushes.Queue.enqueue(oa_id, {
          self(), {:push!, [access_token, to, messages, options]}})

    receive do
      res ->
        res
    end
  end

  def multicast(access_token, [_|_] = to, [_|_] = messages, options \\ [],
    oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_list(options) do
    Multicasts.Queue.enqueue(oa_id, {
          self(), {:multicast!, [access_token, to, messages, options]}})

    receive do
      res ->
        res
    end
  end

  def broadcast(access_token, [_|_] = messages, options \\ [], oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_list(options) do
    Broadcasts.Queue.enqueue(oa_id, {
          self(), {:broadcast!, [access_token, messages, options]}})

    receive do
      res ->
        res
    end
  end

  def narrowcast(access_token, [_|_] = messages, recipient, filter, limit, options \\ [],
    oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_map(recipient) and is_map(filter)
  and is_list(options) do
    Narrowcasts.MessageQueue.enqueue(oa_id, {
          self(), {:narrowcast!, [
                      access_token, messages, recipient, filter, limit, options]}})

    receive do
      res ->
        res
    end
  end
end
