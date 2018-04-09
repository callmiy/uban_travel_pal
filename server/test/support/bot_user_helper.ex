defmodule Urban.BotUserTestHelper do
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
