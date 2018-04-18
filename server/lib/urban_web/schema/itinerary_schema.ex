defmodule UrbanWeb.ItinerarySchema do
  @moduledoc """
  Schema types for Itinerary
  """

  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Urban.Repo

  alias UrbanWeb.ItineraryResolver, as: Resolver

  @desc "An itinerary image"
  object :itinerary_image do
    field(:is_local, non_null(:boolean))
    field(:url, non_null(:string))
  end

  @desc "An itineray"
  object :itinerary do
    field(:id, non_null(:id))
    field(:title, non_null(:string))
    field(:description, :string)

    field :image, non_null(:itinerary_image) do
      resolve(&Resolver.image_url/3)
    end

    field(:booking_url, :string)
    field(:inserted_at, non_null(:iso_datetime))
    field(:updated_at, non_null(:iso_datetime))
  end

  @desc "List of itineraries"
  object :itineraries do
    field(:itineraries, list_of(:itinerary))
  end

  @desc "Queries allowed on itinerary resource"
  object :itinerary_query do
    field :itineraries, type: list_of(:itinerary) do
      resolve(&Resolver.itineraries/3)
    end

    field :x_random_itineraries, type: list_of(:itinerary) do
      arg(:how_many, non_null(:string))

      resolve(&Resolver.x_random_itineraries/3)
    end
  end
end
