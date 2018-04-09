defmodule Urban.BotUserTest do
  use Urban.DataCase

  alias Urban.BotUserApi, as: Api
  alias Urban.BotUser
  alias Urban.BotUserTestHelper, as: Helper

  test "list_bot_users/0 returns all bot_users" do
    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())
    assert Api.list_bot_users() == [bot_user]
  end

  test "get_bot_user!/1 returns the bot_user with given id" do
    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())
    assert Api.get_bot_user!(bot_user.id) == bot_user
  end

  test "get_by/1 succeeds when bot user exists" do
    valid_attrs = Helper.valid_attrs()
    Api.create_bot_user(valid_attrs)

    assert Api.get_by(bot_user_id: valid_attrs.bot_user_id)
  end

  test "create_bot_user/1 with all valid data present succeeds" do
    valid_attrs = Helper.valid_attrs()

    assert {
             :ok,
             %BotUser{} = bot_user
           } = Api.create_bot_user(valid_attrs)

    assert bot_user.email == valid_attrs.email
    assert bot_user.bot_user_id == valid_attrs.bot_user_id
    assert bot_user.user_response_name == valid_attrs.user_response_name
  end

  test "create_bot_user/1 with bot_user_id only succeeds" do
    valid_attrs_bot_user_id_only = Helper.valid_attrs_bot_user_id_only()

    assert {
             :ok,
             %BotUser{} = bot_user
           } = Api.create_bot_user(valid_attrs_bot_user_id_only)

    assert bot_user.email == nil
    assert bot_user.user_response_name == nil
    assert bot_user.bot_user_id == valid_attrs_bot_user_id_only.bot_user_id
  end

  test "create_bot_user/1 with invalid data returns error changeset" do
    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.create_bot_user(Helper.invalid_attrs())
  end

  test "update_bot_user/2 with valid data succeeds" do
    update_attrs = Helper.update_attrs()

    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())
    assert {:ok, bot_user} = Api.update_bot_user(bot_user, update_attrs)
    assert %BotUser{} = bot_user
    assert bot_user.email == update_attrs.email
    assert bot_user.bot_user_id == update_attrs.bot_user_id
    assert bot_user.user_response_name == update_attrs.user_response_name
  end

  test "update_bot_user/2 without bot_user_id succeeds" do
    valid_attrs_bot_user_id_only = Helper.valid_attrs_bot_user_id_only()
    update_attrs_no_bot_user_id = Helper.update_attrs_no_bot_user_id()

    {:ok, bot_user} = Api.create_bot_user(valid_attrs_bot_user_id_only)

    assert {:ok, bot_user} =
             Api.update_bot_user(
               bot_user,
               update_attrs_no_bot_user_id
             )

    assert %BotUser{} = bot_user
    assert bot_user.bot_user_id == valid_attrs_bot_user_id_only.bot_user_id
    assert bot_user.email == update_attrs_no_bot_user_id.email

    user_response_name = update_attrs_no_bot_user_id.user_response_name

    assert bot_user.user_response_name == user_response_name
  end

  test "update_bot_user/2 with invalid data returns error changeset" do
    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())

    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.update_bot_user(bot_user, Helper.invalid_attrs())

    assert bot_user == Api.get_bot_user!(bot_user.id)
  end

  test "delete_bot_user/1 deletes the bot_user" do
    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())
    assert {:ok, %BotUser{}} = Api.delete_bot_user(bot_user)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get_bot_user!(bot_user.id)
    end
  end

  test "change_bot_user/1 returns a bot_user changeset" do
    {:ok, bot_user} = Api.create_bot_user(Helper.valid_attrs())
    assert %Ecto.Changeset{} = Api.change_bot_user(bot_user)
  end
end
