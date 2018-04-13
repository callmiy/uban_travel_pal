defmodule Urban.UtilsTest do
  use Urban.DataCase
  import Urban.Utils

  alias Urban.Repo

  test "list_comma_separated_with_and/1 succeeds for empty list" do
    assert "" == list_comma_separated_with_and([])
  end

  test "list_comma_separated_with_and/1 succeeds for one member list" do
    assert "yoo" == list_comma_separated_with_and(["yoo"])
  end

  test "list_comma_separated_with_and/1 succeeds for 2 members list" do
    assert "yoo and yah" == list_comma_separated_with_and(["yoo", "yah"])
  end

  test "list_comma_separated_with_and/1 succeeds for 3 members list" do
    assert "yeh, yoo and yah" ==
             list_comma_separated_with_and([
               "yeh",
               "yoo",
               "yah"
             ])
  end

  test "ecto_schema_to_map/1 succeeds when struct has no loaded associations" do
    bot_user = insert(:bot_user)
    bot_user_map = ecto_schema_to_map(bot_user)

    assert bot_user.id == bot_user_map.id
    refute Map.has_key?(bot_user_map, :__meta__)
    refute Map.has_key?(bot_user_map, :bot_interactions)
  end

  test "ecto_schema_to_map/1 succeeds when struct has loaded associations" do
    bot_user = insert(:bot_user) |> Repo.preload([:bot_interactions])
    bot_user_map = ecto_schema_to_map(bot_user)

    assert bot_user.id == bot_user_map.id
    refute Map.has_key?(bot_user_map, :__meta__)
    assert Map.has_key?(bot_user_map, :bot_interactions)
  end
end
