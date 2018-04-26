defmodule UrbanWeb.BotUserNameEmailController do
  use UrbanWeb, :controller

  alias Urban.BotUserNameEmailApi, as: Api
  alias Urban.BotUserNameEmail

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    bots = Api.list()
    render(conn, "index.json", bots: bots)
  end

  def create(conn, %{"bot" => params}) do
    with {:ok, %BotUserNameEmail{} = bot} <- Api.create_(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", bot_user_name_email_path(conn, :show, bot))
      |> render("show.json", bot: bot)
    end
  end

  def show(conn, %{"id" => id}) do
    bot = Api.get!(id)
    render(conn, "show.json", bot: bot)
  end

  def update(conn, %{"id" => id, "bot" => params}) do
    bot = Api.get!(id)

    with {:ok, %BotUserNameEmail{} = bot} <- Api.update_(bot, params) do
      render(conn, "show.json", bot: bot)
    end
  end

  def delete(conn, %{"id" => id}) do
    bot = Api.get!(id)

    with {:ok, %BotUserNameEmail{}} <- Api.delete_(bot) do
      send_resp(conn, :no_content, "")
    end
  end
end
