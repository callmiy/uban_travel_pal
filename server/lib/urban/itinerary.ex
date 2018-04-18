defmodule Urban.Itinerary do
  use Ecto.Schema
  use Arc.Ecto.Schema

  import Ecto.Changeset

  alias Urban.Attachment

  @timestamps_opts [
    type: Timex.Ecto.DateTime,
    autogenerate: {Timex.Ecto.DateTime, :autogenerate, []}
  ]

  @cast_attrs [:title, :description, :booking_url]

  schema "itineraries" do
    field(:title, :string)
    field(:description, :string)
    field(:image, Attachment.Type)
    field(:booking_url, :string)

    timestamps()
  end

  def changeset(it, attrs \\ %{})

  def changeset(%{inserted_at: nil, updated_at: nil} = it, attrs) do
    %{microsecond: {ms, _}} = now = Timex.now()
    # default microseconds is 6-precision, but when doing query, the datetime is
    # truncated to 3-precision. So we insert with 3-precision
    now = %{now | microsecond: {ms, 3}}

    it =
      it
      |> change(attrs)
      |> put_change(:updated_at, now)
      |> put_change(:inserted_at, now)

    changeset(it, attrs)
  end

  @doc false
  def changeset(it, attrs) do
    it
    |> cast(attrs, @cast_attrs)
    |> unique_constraint(:title, name: :itineraries_title)
    |> cast_attachments(attrs, [:image])
    |> validate_required([:title, :image])
  end
end
