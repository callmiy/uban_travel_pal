defmodule Urban.TravelPref do
  use Ecto.Schema
  import Ecto.Changeset
  alias Urban.BotInteraction

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  schema "travel_prefs" do
    field(:city, :string)
    field(:budget, :string)
    field(:activities, {:array, :string})
    field(:plan_type, :string)
    field(:first_time_in_city, :boolean)
    belongs_to(:bot_interaction, BotInteraction)

    timestamps()
  end

  @doc false
  def changeset(travel_pref, attrs \\ %{}) do
    travel_pref
    |> cast(attrs, [
      :first_time_in_city,
      :plan_type,
      :city,
      :budget,
      :activities,
      :bot_interaction_id
    ])
    |> validate_required([
      :first_time_in_city,
      :plan_type,
      :city,
      :budget,
      :activities,
      :bot_interaction_id
    ])
    |> assoc_constraint(:bot_interaction)
  end
end
