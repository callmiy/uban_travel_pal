defmodule Urban.Repo.Migrations.CreateTravelPreferences do
  use Ecto.Migration

  def change do
    create table(:travel_preferences) do
      add(:tourist_attraction, :boolean, null: false)
      add(:purpose, {:array, :string}, null: false)
      add(:plan_type, :string, null: false)
      add(:meet_locals, :boolean, null: false)
      add(:city, :string, null: false)
      add(:budget, :string, null: false)
      add(:activities, {:array, :string}, null: false)

      add(
        :bot_interaction_id,
        references(:bot_interactions, on_delete: :delete_all),
        null: false
      )

      timestamps()
    end

    create(index(:travel_preferences, [:bot_interaction_id]))
  end
end
