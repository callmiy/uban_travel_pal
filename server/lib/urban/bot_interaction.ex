defmodule Urban.BotInteraction do
  use Ecto.Schema
  import Ecto.Changeset

  alias Urban.BotUser
  alias Urban.TravelPref

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  @metadata_keys ~w{
    firstTimeUser
    browserName
    browserVersion
    operatingSystem
    operatingSystemVersion
  }

  schema "bot_interactions" do
    field(:bot_connection_id, :string)
    field(:bot_id, :string)
    field(:bot_name, :string)
    field(:bot_platform, :string)
    field(:channel_id, :string)
    field(:datetime, Timex.Ecto.DateTime)
    field(:message, :string)
    field(:message_type, :string)
    field(:metadata, :map)
    field(:response_path, :string)
    belongs_to(:bot_user, BotUser)
    has_one(:travel_pref, TravelPref)

    timestamps()
  end

  @doc false
  def changeset(bot_interaction, attrs) do
    bot_interaction
    |> cast(attrs, [
      :response_path,
      :bot_id,
      :bot_connection_id,
      :bot_name,
      :bot_platform,
      :channel_id,
      :datetime,
      :metadata,
      :message,
      :message_type,
      :bot_user_id
    ])
    |> validate_required([
      :response_path,
      :bot_id,
      :bot_connection_id,
      :bot_name,
      :bot_platform,
      :channel_id,
      :datetime,
      :metadata,
      :message,
      :message_type,
      :bot_user_id
    ])
    |> assoc_constraint(:bot_user)
    |> validate_change(:metadata, fn _, metadata ->
      if Enum.all?(@metadata_keys, &Map.has_key?(metadata, &1)) do
        []
      else
        [metadata: "Required keys missing"]
      end
    end)
  end
end
