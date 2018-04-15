defmodule Urban.BotInteractionHelper do
  import Urban.Factory

  alias Urban.Utils
  alias Urban.BotInteractionApi

  def make_params(attrs \\ %{}) do
    user = insert(:bot_user)

    params =
      :bot_int
      |> build(Enum.into(%{bot_user_id: user.id}, attrs))
      |> Map.from_struct()

    {params, user}
  end

  @doc """
  We construct a factory for bot interaction such that we assign a key
  :user_id which corresponds to :bot_user_id of Urban.BotUser. Thw key
  user_id is what the frontend chatting platform uses
  """
  def make_params_chat_platform_bot_user(bot_user_id, attrs \\ %{}) do
    :bot_int
    |> build(attrs)
    |> Map.from_struct()
    |> Map.put(:user_id, bot_user_id)
  end

  def validate_attrs_equal(map1, map2) do
    Utils.validate_keys_vals_equal(BotInteractionApi.attributes(), map1, map2)
  end
end
