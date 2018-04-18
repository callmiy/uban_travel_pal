defmodule UrbanWeb.Schema do
  use Absinthe.Schema

  import_types(Absinthe.Type.Custom)
  import_types(UrbanWeb.SchemaTypes)
  import_types(UrbanWeb.ItinerarySchema)

  query do
    import_fields(:itinerary_query)
  end
end
