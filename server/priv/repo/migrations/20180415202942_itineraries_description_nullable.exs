defmodule Urban.Repo.Migrations.ItinerariesDescriptionNullable do
  use Ecto.Migration

  def change do
    alter table("itineraries") do
      modify(:description, :string, null: true)
    end
  end
end
