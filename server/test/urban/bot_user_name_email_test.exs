defmodule Urban.BotUserNameEmailTest do
  use Urban.DataCase

  alias Urban.BotUserNameEmailApi, as: Api
  alias Urban.BotUserNameEmail

  test "list/0 returns all bot_user_name_emails" do
    bot = make_()
    assert Api.list() == [bot]
  end

  test "get!/1 returns the bot_user_name_email with given id" do
    bot = make_()
    assert Api.get!(bot.id) == bot
  end

  test "create_/1 with valid data creates a bot_user_name_email" do
    %{name: name, email: email} =
      attrs =
      :bot_user_name_email
      |> build()
      |> Map.from_struct()

    assert {:ok, %BotUserNameEmail{} = bot} = Api.create_(attrs)

    assert bot.email == email
    assert bot.name == name
  end

  test "create_/1 with invalid data returns error changeset" do
    attrs =
      :bot_user_name_email
      |> build(name: nil)
      |> Map.from_struct()

    assert {:error, %Ecto.Changeset{}} = Api.create_(attrs)
  end

  test "create_/1 with none unique name and email returns error" do
    bot = make_()

    attrs =
      :bot_user_name_email
      |> build(name: bot.name, email: bot.email)
      |> Map.from_struct()

    assert {:error, %Ecto.Changeset{}} = Api.create_(attrs)
  end

  test "create_/1 with none unique name and email returns error case insensitive" do
    bot = make_(%{name: "alldowncasename"})
    name = bot.name |> String.upcase()

    attrs =
      :bot_user_name_email
      |> build(name: name, email: bot.email)
      |> Map.from_struct()

    assert {:error, %Ecto.Changeset{}} = Api.create_(attrs)
  end

  test "update_/2 with valid data updates the bot_user_name_email" do
    bot = make_()

    assert {:ok, bot} = Api.update_(bot, %{name: "updated name"})
    assert %BotUserNameEmail{} = bot
    assert bot.name == "updated name"
  end

  test "update_/2 with invalid data returns error changeset" do
    bot = make_()

    assert {:error, %Ecto.Changeset{}} = Api.update_(bot, %{name: nil})
    assert bot == Api.get!(bot.id)
  end

  test "delete_/1 deletes the bot_user_name_email" do
    bot = make_()
    assert {:ok, %BotUserNameEmail{}} = Api.delete_(bot)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get!(bot.id)
    end
  end

  test "change_/1 returns a bot_user_name_email changeset" do
    bot = make_()
    assert %Ecto.Changeset{} = Api.change_(bot)
  end

  def make_(attrs \\ %{}) do
    {:ok, bot} =
      :bot_user_name_email
      |> build(attrs)
      |> Map.from_struct()
      |> Api.create_()

    bot
  end
end
