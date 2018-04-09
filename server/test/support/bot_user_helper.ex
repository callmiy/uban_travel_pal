defmodule Urban.BotUserTestHelper do
  alias Urban.BotUserApi, as: Api
  alias Urban.BotUser

  def create_bot_user(attrs \\ %{}) do
    {
      :ok,
      %BotUser{} = bot_user
    } =
      attrs
      |> Enum.into(valid_attrs())
      |> Api.create_bot_user()

    bot_user
  end

  def valid_attrs do
    %{
      email: "me@bot_user.com",
      bot_user_id: "some bot_user_id",
      user_response_name: "some user_response_name"
    }
  end

  def valid_attrs_bot_user_id_only do
    %{
      bot_user_id: "some bot_user_id"
    }
  end

  def update_attrs_no_bot_user_id do
    %{
      email: "me1@bot_user.com",
      user_response_name: "some updated user_response_name"
    }
  end

  def update_attrs do
    %{
      email: "me1@bot_user.com",
      bot_user_id: "some updated bot_user_id",
      user_response_name: "some updated user_response_name"
    }
  end

  def invalid_attrs do
    %{email: nil, bot_user_id: nil, user_response_name: nil}
  end
end
