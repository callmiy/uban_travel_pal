defmodule UrbanWeb.BotInteractionController do
  use UrbanWeb, :controller

  alias Urban.BotInteractionApi, as: Api
  alias Urban.BotInteraction
  alias Urban.BotUserApi

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    bot_ints = Api.list()
    render(conn, "index.json", bot_interactions: bot_ints)
  end

  def create(conn, %{"bot_interaction" => params}) do
    {
      user_id,
      bot_int
    } = Map.pop(params, "user_id")

    with {:ok, bot_user} <- get_or_create_bot_user(user_id),
         {:ok, %BotInteraction{id: id} = bot_int} <-
           Api.create_bot_int(
             Map.put(
               bot_int,
               "bot_user_id",
               bot_user.id
             )
           ) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        bot_interaction_path(conn, :show, bot_int)
      )
      |> render("show_with_user.json", user: bot_user, bot_interaction_id: id)
    end
  end

  def show(conn, %{"id" => id}) do
    bot_int = Api.get!(id)
    render(conn, "show.json", bot_interaction: bot_int)
  end

  def update(conn, %{"id" => id, "bot_interaction" => bot_int_params}) do
    bot_int = Api.get!(id)

    with {:ok, %BotInteraction{} = bot_int} <- Api.update_bot_int(bot_int, bot_int_params) do
      render(conn, "show.json", bot_interaction: bot_int)
    end
  end

  def delete(conn, %{"id" => id}) do
    bot_int = Api.get!(id)

    with {:ok, %BotInteraction{}} <- Api.delete_bot_int(bot_int) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_or_create_bot_user(user_id) do
    case BotUserApi.get_by(bot_user_id: user_id) do
      nil ->
        with {:ok, user_of_bot} <- BotUserApi.create_bot_user(%{bot_user_id: user_id}) do
          {:ok, user_of_bot}
        end

      user_of_bot ->
        {:ok, user_of_bot}
    end
  end
end
