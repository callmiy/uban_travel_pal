defmodule UrbanWeb.BotUserNameEmailView do
  use UrbanWeb, :view
  alias UrbanWeb.BotUserNameEmailView

  def render("index.json", %{bots: bots}) do
    %{data: render_many(bots, BotUserNameEmailView, "bot.json")}
  end

  def render("show.json", %{bot: bot}) do
    %{data: render_one(bot, BotUserNameEmailView, "bot.json")}
  end

  def render("bot.json", %{bot_user_name_email: bot}) do
    %{
      id: bot.id,
      name: bot.name,
      email: bot.email
    }
  end
end
