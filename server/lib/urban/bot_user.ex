defmodule Urban.BotUser do
  @moduledoc """
  The "bot_user_id" attribute of this struct is the user_id as assigned by
  the chat bot platform and must not be confused with the foreign key
  "bot_user_id" of bot_interactions
  """

  use Ecto.Schema
  import Ecto.Changeset

  alias Urban.BotInteraction

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  @attributes [
    :email,
    :bot_user_id,
    :user_response_name
  ]

  schema "bot_users" do
    field(:email, :string)
    field(:bot_user_id, :string)
    field(:user_response_name, :string)
    has_many(:bot_interactions, BotInteraction)

    timestamps()
  end

  @doc false
  def changeset(bot_user, attrs \\ %{}) do
    bot_user
    |> cast(attrs, [:bot_user_id, :user_response_name, :email])
    |> validate_required([:bot_user_id])
    |> validate_length(:bot_user_id, min: 3)
    |> unique_constraint(
      :bot_user_id_email,
      name: :bot_users_bot_user_id_email_index
    )
    |> validate_format(:email, ~r/@/)
  end

  def attributes do
    @attributes
  end
end
