defmodule Urban.BotUserTest do
  use Urban.DataCase

  alias Urban.BotUserApi, as: Api
  alias Urban.BotUser
  alias Urban.BotUserTestHelper, as: Helper

  test "list_bot_users/0 returns all bot_users" do
    attrs = Helper.make_bot_user()
    {:ok, bot_user} = Api.create_bot_user(attrs)
    assert Api.list_bot_users() == [bot_user]
  end

  test "get_bot_user!/1 returns the bot_user with given id" do
    attrs = Helper.make_bot_user()
    {:ok, bot_user} = Api.create_bot_user(attrs)
    assert Api.get_bot_user!(bot_user.id) == bot_user
  end

  test "get_by/1 succeeds when bot user exists" do
    %{bot_user_id: bot_user_id} = attrs = Helper.make_bot_user()
    Api.create_bot_user(attrs)

    assert Api.get_by(bot_user_id: bot_user_id)
  end

  test "create_bot_user/1 with all valid data present succeeds" do
    attrs = Helper.make_bot_user()

    assert {
             :ok,
             %BotUser{} = bot_user
           } = Api.create_bot_user(attrs)

    assert bot_user.email == attrs.email
    assert bot_user.bot_user_id == attrs.bot_user_id
    assert bot_user.user_response_name == attrs.user_response_name
  end

  test "create_bot_user/1 with bot_user_id only succeeds" do
    attrs = Helper.make_bot_user(%{email: nil, user_response_name: nil})

    assert {:ok, %BotUser{} = bot_user} = Api.create_bot_user(attrs)
    assert bot_user.email == nil
    assert bot_user.user_response_name == nil
    assert bot_user.bot_user_id == attrs.bot_user_id
  end

  test "create_bot_user/1 with invalid data returns error changeset" do
    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.create_bot_user(Helper.make_bot_user(%{bot_user_id: nil}))
  end

  test "update_bot_user/2 with valid data succeeds" do
    update_attrs = %{bot_user_id: "updated bot user id"}
    bot_user = insert(:bot_user)

    assert {
             :ok,
             %BotUser{bot_user_id: "updated bot user id"} = bot_user_
           } = Api.update_bot_user(bot_user, update_attrs)

    refute bot_user_.bot_user_id == bot_user.bot_user_id
  end

  test "update_bot_user/2 with invalid data returns error changeset" do
    {:ok, bot_user} = Api.create_bot_user(Helper.make_bot_user())

    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.update_bot_user(bot_user, %{bot_user_id: nil})

    assert bot_user == Api.get_bot_user!(bot_user.id)
  end

  test "delete_bot_user/1 deletes the bot_user" do
    bot_user = insert(:bot_user)
    assert {:ok, %BotUser{}} = Api.delete_bot_user(bot_user)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get_bot_user!(bot_user.id)
    end
  end

  test "change_bot_user/1 returns a bot_user changeset" do
    assert %Ecto.Changeset{} = Api.change_bot_user(insert(:bot_user))
  end

  test "to_encodable_map/1 succeeds when related bot interactions not loaded" do
    bot_user = insert(:bot_user)
    bot_user_map = Api.to_encodable_map(bot_user)
    assert Helper.validate_attrs_equal(bot_user, bot_user_map)
  end
end
