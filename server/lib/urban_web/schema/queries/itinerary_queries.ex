defmodule UrbanWeb.ItineraryQueries do
  def query(:itineraries) do
    """
    query Itineraries {
      itineraries {
        id
        title
        description
        inserted_at
        updated_at
        booking_url
        image {
          url
          is_local
        }
      }
    }
    """
  end

  def query(:x_random_itineraries) do
    """
    query XRandomItineraries($how_many: String!) {
      xRandomItineraries(how_many: $how_many) {
        id
        title
        description
        insertedAt
        updatedAt
        bookingUrl
        image {
          url
          is_local
        }
      }
    }
    """
  end
end
