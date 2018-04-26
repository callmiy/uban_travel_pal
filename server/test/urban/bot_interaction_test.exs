defmodule Urban.BotInteractionTest do
  use Urban.DataCase

  alias Urban.BotInteractionApi, as: Api
  alias Urban.BotInteraction
  alias Urban.BotInteractionHelper, as: Helper
  alias Urban.Utils

  test "list/0 returns all bot_interactions" do
    {params, _user} = Helper.make_params()
    {:ok, bot_int} = Api.create_bot_int(params)
    [bot_int_] = Api.list()

    assert normalize_dt(bot_int_) == normalize_dt(bot_int)
  end

  test "get!/1 returns the bot_interaction with given id" do
    {params, _user} = Helper.make_params()
    {:ok, bot_int} = Api.create_bot_int(params)
    bot_int_ = Api.get!(bot_int.id)

    assert normalize_dt(bot_int_) == normalize_dt(bot_int)
  end

  test "create_bot_int/1 with valid data creates a bot_interaction" do
    {params, _user} = Helper.make_params()

    assert {
             :ok,
             %BotInteraction{} = bot_int
           } = Api.create_bot_int(params)

    assert Helper.validate_attrs_equal(params, Map.from_struct(bot_int))
  end

  test "create_bot_int/1 with invalid data returns error changeset" do
    {invalid_attrs, _user} = Helper.make_params(%{bot_platform: nil})

    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.create_bot_int(invalid_attrs)
  end

  test "update_bot_int/2 with valid data updates the bot_interaction" do
    {params, _user} = Helper.make_params()
    {:ok, bot_int} = Api.create_bot_int(params)

    assert {
             :ok,
             %BotInteraction{bot_name: "updated bot name"} = bot_int_
           } =
             Api.update_bot_int(bot_int, %{
               bot_name: "updated bot name"
             })

    refute bot_int_.bot_name == bot_int.bot_name
  end

  test "update_bot_int/2 with invalid data returns error changeset" do
    {params, _user} = Helper.make_params()

    {:ok, bot_int} = Api.create_bot_int(params)

    assert {
             :error,
             %Ecto.Changeset{}
           } = Api.update_bot_int(bot_int, %{bot_platform: nil})

    bot_int_ = Api.get!(bot_int.id)
    bot_int1 = normalize_dt(bot_int)
    bot_int2 = normalize_dt(bot_int_)
    assert bot_int1 == bot_int2
  end

  test "delete_bot_int/1 deletes the bot_interaction" do
    bot_int = insert(:bot_int)

    assert {:ok, %BotInteraction{}} = Api.delete_bot_int(bot_int)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get!(bot_int.id)
    end
  end

  test "change_bot_int/1 returns a bot_interaction changeset" do
    bot_int = insert(:bot_int)
    assert %Ecto.Changeset{} = Api.change_bot_int(bot_int)
  end

  defp normalize_dt(%BotInteraction{datetime: dt} = bot_int) do
    %{bot_int | datetime: Utils.normalize_time(dt)}
  end
end
