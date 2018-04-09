defmodule UrbanWeb.TravelPreferenceView do
  use UrbanWeb, :view
  alias UrbanWeb.TravelPreferenceView

  def render("index.json", %{travel_preferences: travel_preferences}) do
    %{data: render_many(travel_preferences, TravelPreferenceView, "travel_preference.json")}
  end

  def render("show.json", %{travel_preference: travel_preference}) do
    %{data: render_one(travel_preference, TravelPreferenceView, "travel_preference.json")}
  end

  def render("travel_preference.json", %{travel_preference: travel_preference}) do
    %{id: travel_preference.id,
      tourist_attraction: travel_preference.tourist_attraction,
      purpose: travel_preference.purpose,
      plan_type: travel_preference.plan_type,
      meet_locals: travel_preference.meet_locals,
      city: travel_preference.city,
      budget: travel_preference.budget,
      activities: travel_preference.activities}
  end
end
