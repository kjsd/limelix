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


  def reply(access_token, reply_token, [_|_] = messages, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(reply_token) do
    Replies.Queue.enqueue(oa_id, {
          self(), {:reply!, [access_token, reply_token, messages]}})

    receive do
      res ->
        res
    end
  end

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

  def progress_narrowcast(access_token, request_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(request_id) do
    Narrowcasts.RequestQueue.enqueue(oa_id, {
          self(), {:progress_narrowcast!, [
                      access_token, request_id]}})

    receive do
      res ->
        res
    end
  end

  def create_audience(access_token, description, [_|_] = uid, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(description) do
    Narrowcasts.AudienceQueue.enqueue(oa_id, {
          self(), {:create_audience!, [
                      access_token, description, uid]}})

    receive do
      res ->
        res
    end
  end

  def merge_audience(access_token, audience_id, description, [_|_] = uid,
    oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_integer(audience_id) and is_binary(description) do
    Narrowcasts.AudienceQueue.enqueue(oa_id, {
          self(), {:merge_audience!, [
                      access_token, audience_id, description, uid]}})

    receive do
      res ->
        res
    end
  end

  def delete_audience(access_token, audience_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_integer(audience_id) do
    Narrowcasts.AudienceQueue.enqueue(oa_id, {
          self(), {:delete_audience!, [
                      access_token, audience_id]}})

    receive do
      res ->
        res
    end
  end

  def create_richmenu(access_token, richmenu, image_url, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_map(richmenu) and is_binary(image_url) do
    Richmenus.ContentQueue.enqueue(oa_id, {
          self(), {:create_richmenu!, [
                      access_token, richmenu, image_url]}})

    receive do
      res ->
        res
    end
  end

  def delete_richmenu(access_token, richmenu_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(richmenu_id) do
    Richmenus.ContentQueue.enqueue(oa_id, {
          self(), {:delete_richmenu!, [
                      access_token, richmenu_id]}})

    receive do
      res ->
        res
    end
  end

  def get_richmenu(access_token, richmenu_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(richmenu_id) do
    Richmenus.RequestQueue.enqueue(oa_id, {
          self(), {:get_richmenu!, [
                      access_token, richmenu_id]}})

    receive do
      res ->
        res
    end
  end

  def alias_richmenu(access_token, richmenu_id, alias_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(richmenu_id) and is_binary(alias_id) do
    Richmenus.RequestQueue.enqueue(oa_id, {
          self(), {:alias_richmenu!, [
                      access_token, richmenu_id, alias_id]}})

    receive do
      res ->
        res
    end
  end

  def unalias_richmenu(access_token, alias_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(alias_id) do
    Richmenus.ContentQueue.enqueue(oa_id, {
          self(), {:unalias_richmenu!, [
                      access_token, alias_id]}})

    receive do
      res ->
        res
    end
  end

  def link_richmenu(access_token, richmenu_id, [_|_] = to, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(richmenu_id) do
    Richmenus.RequestQueue.enqueue(oa_id, {
          self(), {:link_richmenu!, [
                      access_token, richmenu_id, to]}})

    receive do
      res ->
        res
    end
  end

  def unlink_richmenu(access_token, [_|_] = to, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) do
    Richmenus.RequestQueue.enqueue(oa_id, {
          self(), {:unlink_richmenu!, [
                      access_token, to]}})

    receive do
      res ->
        res
    end
  end

  def get_profile(access_token, user_id, oa_id \\ "LIMELIX_LINEOA")
  when is_binary(access_token) and is_binary(user_id) do
    Users.Queue.enqueue(oa_id, {
          self(), {:get_profile!, [
                      access_token, user_id]}})

    receive do
      res ->
        res
    end
  end
end
