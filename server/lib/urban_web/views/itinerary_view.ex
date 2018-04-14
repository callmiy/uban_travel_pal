defmodule UrbanWeb.ItineraryView do
  use UrbanWeb, :view
  alias UrbanWeb.ItineraryView

  def render("index.json", %{itinerarys: itinerarys}) do
    %{data: render_many(itinerarys, ItineraryView, "itinerary.json")}
  end

  def render("show.json", %{itinerary: itinerary}) do
    %{data: render_one(itinerary, ItineraryView, "itinerary.json")}
  end

  def render("itinerary.json", %{itinerary: itinerary}) do
    %{
      id: itinerary.id,
      title: itinerary.title,
      description: itinerary.description,
      image: itinerary.image
    }
  end
end
