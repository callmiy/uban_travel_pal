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
    field(:purpose, {:array, :string})
    field(:activities, {:array, :string})
    field(:tourist_attraction, :boolean)
    field(:meet_locals, :boolean)
    field(:plan_type, :string)
    belongs_to(:bot_interaction, BotInteraction)

    timestamps()
  end

  @doc false
  def changeset(travel_pref, attrs) do
    travel_pref
    |> cast(attrs, [
      :tourist_attraction,
      :purpose,
      :plan_type,
      :meet_locals,
      :city,
      :budget,
      :activities,
      :bot_interaction_id
    ])
    |> validate_required([
      :tourist_attraction,
      :purpose,
      :plan_type,
      :meet_locals,
      :city,
      :budget,
      :activities,
      :bot_interaction_id
    ])
    |> assoc_constraint(:bot_interaction)
  end
end
