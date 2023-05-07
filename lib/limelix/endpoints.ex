defmodule Limelix.Endpoints do
  require Logger

  def content_richmenu({endpoint, arg}) do
    case endpoint do
      :create_richmenu! ->
        apply(__MODULE__, :create_richmenu, arg)

      _ ->
        line_api({endpoint, arg})
    end
  end

  def create_richmenu(access_token, message, image_url) do
    with {:ok, {_, %{"richMenuId" => id}, _}} = res
    <- line_api({:create_richmenu!, [access_token, message]}) do

      res_upload =
        try do
          LINEDevelopers.upload_richmenu_image!(image_url, access_token, id)
        rescue
          e ->
            {:error, e}
        end

      with {:error, _} <- res_upload do
        "#{__MODULE__}:create_richmenu #{inspect(res_upload)}"
        |> Logger.error()

        res_upload
      else
        _ -> res
      end
    end
  end

  def line_api({endpoint, args}) do
    res =
      try do
        LINEDevelopers.messaging_api()
        |> apply(endpoint, args)
      rescue
        e ->
          {:error, e}
      end

    with {:error, _} <- res do
      "#{__MODULE__}:#{endpoint} #{inspect(res)}"
      |> Logger.error()

      res
    end
  end

  def echo(x), do: x
end
