defmodule Urban.BotInteractionHelper do
  alias Urban.BotUserTestHelper
  alias Urban.BotUserApi
  alias Urban.{BotUser, BotInteraction}
  alias Urban.BotInteractionApi, as: Api

  @now Timex.now()

  @metadata %{
    "firstTimeUser" => true,
    "browserName" => "Chrome Mobile",
    "browserVersion" => "65.0.3325.181",
    "operatingSystem" => "Android",
    "operatingSystemVersion" => "5.0",
    "deviceProduct" => "Galaxy S5",
    "mobile" => true
  }

  def create_bot_interaction(attrs \\ %{}) do
    {:ok, %BotInteraction{} = interaction} =
      attrs
      |> Enum.into(valid_attrs())
      |> Api.create_bot_interaction()

    interaction
  end

  def create_bot_user do
    {
      :ok,
      bot_user
    } = BotUserApi.create_bot_user(BotUserTestHelper.valid_attrs())

    bot_user
  end

  def valid_attrs do
    %BotUser{id: bot_user_id} = create_bot_user()

    %{
      bot_connection_id: "some bot_connection_id",
      bot_id: "some bot_id",
      bot_name: "some bot_name",
      bot_platform: "some bot_platform",
      channel_id: "some channel_id",
      datetime: @now,
      message: "some message",
      message_type: "some message_type",
      metadata: @metadata,
      response_path: "some response_path",
      bot_user_id: bot_user_id
    }
  end

  def valid_attrs_no_user do
    %{
      bot_connection_id: "some bot_connection_id",
      bot_id: "some bot_id",
      bot_name: "some bot_name",
      bot_platform: "some bot_platform",
      channel_id: "some channel_id",
      datetime: @now,
      message: "some message",
      message_type: "some message_type",
      metadata: @metadata,
      response_path: "some response_path"
    }
  end

  def update_attrs do
    %{
      bot_connection_id: "some updated bot_connection_id",
      bot_id: "some updated bot_id",
      bot_name: "some updated bot_name",
      bot_platform: "some updated bot_platform",
      channel_id: "some updated channel_id",
      datetime: Timex.shift(@now, hours: 5),
      message: "some updated message",
      message_type: "some updated message_type",
      metadata: @metadata,
      response_path: "some updated response_path"
    }
  end

  def invalid_attrs do
    %{
      bot_connection_id: nil,
      bot_id: nil,
      bot_name: nil,
      bot_platform: nil,
      channel_id: nil,
      datetime: nil,
      message: nil,
      message_type: nil,
      metadata: nil,
      response_path: nil
    }
  end

  def invalid_attrs_with_valid_user_id do
    %{
      bot_connection_id: nil,
      bot_id: nil,
      bot_name: nil,
      bot_platform: nil,
      channel_id: nil,
      datetime: nil,
      message: nil,
      message_type: nil,
      metadata: nil,
      response_path: nil,
      user_id: "new bot user id"
    }
  end
end
