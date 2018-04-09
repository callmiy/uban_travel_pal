defmodule UrbanWeb.TravelPreferenceController do
  use UrbanWeb, :controller

  alias Urban.TravelPreferenceApi
  alias Urban.TravelPreference

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    travel_preferences = TravelPreferenceApi.list_pref()
    render(conn, "index.json", travel_preferences: travel_preferences)
  end

  def create(conn, %{"travel_preference" => params}) do
    with {:ok, pref} <- TravelPreferenceApi.create_pref(params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        travel_preference_path(conn, :show, pref)
      )
      |> render("show.json", travel_preference: pref)
    end
  end

  def show(conn, %{"id" => id}) do
    pref = TravelPreferenceApi.get_pref!(id)
    render(conn, "show.json", travel_preference: pref)
  end

  def update(conn, %{"id" => id, "travel_preference" => params}) do
    pref = TravelPreferenceApi.get_pref!(id)

    with {:ok, %TravelPreference{} = pref_} <-
           TravelPreferenceApi.update_pref(
             pref,
             params
           ) do
      render(conn, "show.json", travel_preference: pref_)
    end
  end

  def delete(conn, %{"id" => id}) do
    pref = TravelPreferenceApi.get_pref!(id)

    with {:ok, %TravelPreference{}} <- TravelPreferenceApi.delete_pref(pref) do
      send_resp(conn, :no_content, "")
    end
  end
end
