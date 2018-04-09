defmodule UrbanWeb.BotUserView do
  use UrbanWeb, :view
  alias UrbanWeb.BotUserView

  def render("index.json", %{bot_users: bot_users}) do
    %{data: render_many(bot_users, BotUserView, "bot_user.json")}
  end

  def render("show.json", %{bot_user: bot_user}) do
    %{data: render_one(bot_user, BotUserView, "bot_user.json")}
  end

  def render("bot_user.json", %{bot_user: bot_user}) do
    %{
      id: bot_user.id,
      bot_user_id: bot_user.bot_user_id,
      user_response_name: bot_user.user_response_name,
      email: bot_user.email
    }
  end
end
