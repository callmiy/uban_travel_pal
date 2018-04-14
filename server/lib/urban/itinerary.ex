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
    field(:title, :string)
    field(:description, :string)
    field(:image, Attachment.Type)

    timestamps()
  end

  @doc false
  def changeset(it, attrs \\ %{}) do
    it
    |> changeset_no_image(attrs)
    |> cast_attachments(attrs, [:image])
    |> validate_required([:image])
  end

  def changeset_no_image(it, attrs \\ %{}) do
    it
    |> cast(attrs, [:title, :description])
    |> unique_constraint(:title, name: :itineraries_title)
    |> validate_required([:title, :description])
  end
end
