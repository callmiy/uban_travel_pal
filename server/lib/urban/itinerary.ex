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
  def changeset(it, attrs \\ %{}) do
    IO.inspect(attrs)

    it
    |> cast(attrs, [:title, :description])
    |> unique_constraint(:title, name: :itineraries_title_index)
    |> cast_attachments(attrs, [:image])
    |> validate_required([:title, :description, :image])
  end

  def changeset_manual_image(it, attrs \\ %{}) do
    it
    |> cast(attrs, [:title, :description, :image])
    |> unique_constraint(:title, name: :itineraries_title_index)
    |> validate_required([:title, :description, :image])
  end
end
