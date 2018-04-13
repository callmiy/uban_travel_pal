defmodule Urban.BotUserTestHelper do
  import Urban.Factory
  alias Urban.Utils
  alias Urban.BotUser

  def make_bot_user(attrs \\ %{}) do
    :bot_user
    |> build(attrs)
    |> Map.from_struct()
  end

  def validate_attrs_equal(map1, map2) do
    Utils.validate_keys_vals_equal(BotUser.attributes(), map1, map2)
  end
end
