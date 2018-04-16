defmodule Urban.Repo.Migrations.ItinerariesAddBookingUrl do
  use Ecto.Migration

  def change do
    alter table("itineraries") do
      add(:booking_url, :string)
    end
  end
end
