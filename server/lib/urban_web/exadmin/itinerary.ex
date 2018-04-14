defmodule UrbanWeb.ExAdmin.Itinerary do
  use ExAdmin.Register

  alias Urban.Itinerary

  register_resource Itinerary do
    # actions(:all, except: [:new, :destroy, :edit])
  end
end
