defmodule Urban.Repo.Migrations.TravelPrefAlterFields do
  use Ecto.Migration

  def change do
    alter table("travel_prefs") do
      remove(:purpose)
      remove(:tourist_attraction)
      remove(:meet_locals)
      add(:first_time_in_city, :boolean)
    end
  end
end
