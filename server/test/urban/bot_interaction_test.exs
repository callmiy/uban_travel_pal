defmodule Urban.BotInteractionTest do
  use Urban.DataCase

  alias Urban.BotInteractionApi, as: Api
  alias Urban.BotInteraction
  alias Urban.BotInteractionHelper, as: Helper

  test "list_bot_interactions/0 returns all bot_interactions" do
    {
      :ok,
      bot_interaction
    } = Api.create_bot_interaction(Helper.valid_attrs())

    assert Api.list_bot_interactions() == [bot_interaction]
  end

  test "get_bot_interaction!/1 returns the bot_interaction with given id" do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())
    assert Api.get_bot_interaction!(bot_interaction.id) == bot_interaction
  end

  test "create_bot_interaction/1 with valid data creates a bot_interaction" do
    valid_attrs = Helper.valid_attrs()
    assert {:ok, %BotInteraction{} = bot_interaction} = Api.create_bot_interaction(valid_attrs)

    assert bot_interaction.bot_connection_id == valid_attrs.bot_connection_id
    assert bot_interaction.bot_id == valid_attrs.bot_id
    assert bot_interaction.bot_name == valid_attrs.bot_name
    assert bot_interaction.bot_platform == valid_attrs.bot_platform
    assert bot_interaction.channel_id == valid_attrs.channel_id
    assert bot_interaction.datetime == valid_attrs.datetime
    assert bot_interaction.message == valid_attrs.message
    assert bot_interaction.message_type == valid_attrs.message_type
    assert bot_interaction.metadata == valid_attrs.metadata
    assert bot_interaction.response_path == valid_attrs.response_path
  end

  test "create_bot_interaction/1 with invalid data returns error changeset" do
    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.create_bot_interaction(Helper.invalid_attrs())
  end

  test "update_bot_interaction/2 with valid data updates the bot_interaction" do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())
    update_attrs = Helper.update_attrs()

    assert {:ok, bot_interaction} =
             Api.update_bot_interaction(
               bot_interaction,
               update_attrs
             )

    assert %BotInteraction{} = bot_interaction
    assert bot_interaction.bot_connection_id == update_attrs.bot_connection_id
    assert bot_interaction.bot_id == update_attrs.bot_id
    assert bot_interaction.bot_name == update_attrs.bot_name
    assert bot_interaction.bot_platform == update_attrs.bot_platform
    assert bot_interaction.channel_id == update_attrs.channel_id
    assert bot_interaction.datetime == update_attrs.datetime
    assert bot_interaction.message == update_attrs.message
    assert bot_interaction.message_type == update_attrs.message_type
    assert bot_interaction.metadata == update_attrs.metadata
    assert bot_interaction.response_path == update_attrs.response_path
  end

  test "update_bot_interaction/2 with invalid data returns error changeset" do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())

    assert {:error, %Ecto.Changeset{}} =
             Api.update_bot_interaction(bot_interaction, Helper.invalid_attrs())

    assert bot_interaction == Api.get_bot_interaction!(bot_interaction.id)
  end

  test "delete_bot_interaction/1 deletes the bot_interaction" do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())
    assert {:ok, %BotInteraction{}} = Api.delete_bot_interaction(bot_interaction)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get_bot_interaction!(bot_interaction.id)
    end
  end

  test "change_bot_interaction/1 returns a bot_interaction changeset" do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())
    assert %Ecto.Changeset{} = Api.change_bot_interaction(bot_interaction)
  end
end
