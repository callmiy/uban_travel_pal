defmodule UrbanWeb.ItineraryView do
  use UrbanWeb, :view
  alias UrbanWeb.ItineraryView

  def render("index.json", %{its: its}) do
    %{data: render_many(its, ItineraryView, "it.json")}
  end

  def render("show.json", %{it: nil} = _assigns) do
    %{data: %{first_itinerary: nil}}
  end

  def render("show.json", %{first_it: nil} = _assigns) do
    %{data: %{first_itinerary: nil}}
  end

  def render("show.json", %{first_it: first_it, next_it_ids: next_it_ids}) do
    first_it = render_one(first_it, ItineraryView, "it.json")
    %{data: %{first_itinerary: first_it, next_itinerary_ids: next_it_ids}}
  end

  def render("show.json", %{it: it}) do
    %{data: render_one(it, ItineraryView, "it.json")}
  end

  def render("it.json", %{itinerary: %{image_url: url, local: local} = it} = params) do
    it = Map.drop(it, [:image_url])
    params = %{params | itinerary: it}

    "it.json"
    |> render(params)
    |> Enum.into(%{image_url: url, local: local})
  end

  def render("it.json", %{itinerary: it}) do
    %{
      id: it.id,
      title: it.title,
      description: it.description,
      image: it.image
    }
  end
end
