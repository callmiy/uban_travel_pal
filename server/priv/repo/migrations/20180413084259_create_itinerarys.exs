defmodule Urban.Repo.Migrations.CreateItinerarys do
  use Ecto.Migration

  def change do
    execute("CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;")

    create table(:itineraries) do
      add(:title, :citext, null: false)
      add(:description, :text, null: false)
      add(:image, :string, null: false)

      timestamps()
    end

    execute("""
    CREATE UNIQUE INDEX itineraries_title ON itineraries (lower(title));
    """)
  end
end
