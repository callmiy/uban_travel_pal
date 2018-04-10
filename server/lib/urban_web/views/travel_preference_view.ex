defmodule UrbanWeb.TravelPrefView do
  use UrbanWeb, :view
  alias UrbanWeb.TravelPrefView

  def render("index.json", %{travel_prefs: travel_prefs}) do
    %{data: render_many(travel_prefs, TravelPrefView, "travel_pref.json")}
  end

  def render("show.json", %{travel_pref: travel_pref}) do
    %{data: render_one(travel_pref, TravelPrefView, "travel_pref.json")}
  end

  def render("travel_pref.json", %{travel_pref: travel_pref}) do
    %{
      id: travel_pref.id,
      tourist_attraction: travel_pref.tourist_attraction,
      purpose: travel_pref.purpose,
      plan_type: travel_pref.plan_type,
      meet_locals: travel_pref.meet_locals,
      city: travel_pref.city,
      budget: travel_pref.budget,
      activities: travel_pref.activities
    }
  end
end
