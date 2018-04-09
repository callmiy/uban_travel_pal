defmodule UrbanWeb.BotInteractionView do
  use UrbanWeb, :view
  alias UrbanWeb.BotInteractionView
  alias UrbanWeb.BotUserView

  def render("index.json", %{bot_interactions: bot_interactions}) do
    %{data: render_many(bot_interactions, BotInteractionView, "bot_interaction.json")}
  end

  def render("show.json", %{bot_interaction: bot_interaction}) do
    %{data: render_one(bot_interaction, BotInteractionView, "bot_interaction.json")}
  end

  def render("show_with_user.json", %{bot_interaction_id: id, user: user}) do
    rendered_user =
      render_one(
        user,
        BotUserView,
        "bot_user.json"
      )

    %{
      data: Map.put(rendered_user, :bot_interaction_id, id)
    }
  end

  def render("bot_interaction.json", %{bot_interaction: bot_interaction}) do
    %{
      id: bot_interaction.id,
      response_path: bot_interaction.response_path,
      bot_id: bot_interaction.bot_id,
      bot_connection_id: bot_interaction.bot_connection_id,
      bot_name: bot_interaction.bot_name,
      bot_platform: bot_interaction.bot_platform,
      channel_id: bot_interaction.channel_id,
      datetime: bot_interaction.datetime,
      metadata: bot_interaction.metadata,
      message: bot_interaction.message,
      message_type: bot_interaction.message_type
    }
  end
end
