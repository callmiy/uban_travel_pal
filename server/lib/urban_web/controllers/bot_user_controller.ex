defmodule UrbanWeb.BotUserController do
  use UrbanWeb, :controller

  alias Urban.BotUserApi
  alias Urban.BotUser

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    bot_users = BotUserApi.list_bot_users()
    render(conn, "index.json", bot_users: bot_users)
  end

  def create(conn, %{"bot_user" => bot_user_params}) do
    with {:ok, %BotUser{} = bot_user} <- BotUserApi.create_bot_user(bot_user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", bot_user_path(conn, :show, bot_user))
      |> render("show.json", bot_user: bot_user)
    end
  end

  def show(conn, %{"id" => id}) do
    bot_user = BotUserApi.get_bot_user!(id)
    render(conn, "show.json", bot_user: bot_user)
  end

  def update(conn, %{"id" => id, "bot_user" => bot_user_params}) do
    bot_user = BotUserApi.get_bot_user!(id)

    with {:ok, %BotUser{} = bot_user} <- BotUserApi.update_bot_user(bot_user, bot_user_params) do
      render(conn, "show.json", bot_user: bot_user)
    end
  end

  def delete(conn, %{"id" => id}) do
    bot_user = BotUserApi.get_bot_user!(id)

    with {:ok, %BotUser{}} <- BotUserApi.delete_bot_user(bot_user) do
      send_resp(conn, :no_content, "")
    end
  end
end
