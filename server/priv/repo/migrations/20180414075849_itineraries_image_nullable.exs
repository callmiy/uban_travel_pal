defmodule Urban.Repo.Migrations.ItinerariesImageNullable do
  use Ecto.Migration

  def change do
    alter table("itineraries") do
      modify(:image, :string, null: true)
    end
  end
end
