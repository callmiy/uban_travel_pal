defmodule Urban.BotUserNameEmail do
  use Ecto.Schema
  import Ecto.Changeset

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  schema "bot_user_name_emails" do
    field(:email, :string)
    field(:name, :string)

    timestamps()
  end

  @doc false
  def changeset(bot_user_name_email, attrs) do
    bot_user_name_email
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> unique_constraint(
      :username_email,
      name: :bot_user_name_emails_name_email_index
    )
  end
end
