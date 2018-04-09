defmodule Urban.BotUser do
  use Ecto.Schema
  import Ecto.Changeset

  alias Urban.BotInteraction

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  schema "bot_users" do
    field(:email, :string)
    field(:bot_user_id, :string)
    field(:user_response_name, :string)
    has_many(:bot_interactions, BotInteraction)

    timestamps()
  end

  @doc false
  def changeset(bot_user, attrs) do
    bot_user
    |> cast(attrs, [:bot_user_id, :user_response_name, :email])
    |> validate_required([:bot_user_id])
    |> validate_length(:bot_user_id, min: 3)
    |> unique_constraint(:bot_user_id, name: :bot_users_bot_user_id_email_index)
    |> validate_format(:email, ~r/@/)
  end
end
