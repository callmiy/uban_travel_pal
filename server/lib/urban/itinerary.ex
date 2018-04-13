defmodule Urban.Itinerary do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Urban.Attachment

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  schema "itineraries" do
    field(:description, :string)
    field(:title, :string)
    field(:image, Attachment.Type)

    timestamps()
  end

  @doc false
  def changeset(itinerary, attrs \\ %{}) do
    itinerary
    |> cast(attrs, [:title, :description])
    |> cast_attachments(attrs, [:image])
    |> unique_constraint(:title)
    |> validate_required([:title, :description, :image])
  end
end
