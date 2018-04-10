defmodule Urban.BotUserTestHelper do
  import Urban.Factory

  def make_bot_user(attrs \\ %{}) do
    :bot_user
    |> build(attrs)
    |> Map.from_struct()
  end
end
