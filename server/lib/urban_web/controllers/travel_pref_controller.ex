defmodule UrbanWeb.TravelPrefController do
  use UrbanWeb, :controller

  alias Urban.TravelPrefApi
  alias Urban.TravelPref
  alias Urban.Utils

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    travel_prefs = TravelPrefApi.list_pref()
    render(conn, "index.json", travel_prefs: travel_prefs)
  end

  def create(conn, %{"preferences" => params}) do
    with {:ok, pref} <- TravelPrefApi.create_pref(params) do
      conn
      |> put_status(:created)
      |> put_resp_header(
        "location",
        travel_pref_path(conn, :show, pref)
      )
      |> render("show.json", travel_pref: pref)
    end
  end

  def create(conn, %{"preferences_str" => preferences} = params) do
    %{
      "activities" => a,
      "purpose" => p,
      "tourist_attraction" => t,
      "meet_locals" => m
    } = preferences

    pref =
      %{
        "activities" => Utils.json_string_as_object(a),
        "purpose" => Utils.json_string_as_object(p),
        "tourist_attraction" => Utils.yes_no_to_boolean(t),
        "meet_locals" => Utils.yes_no_to_boolean(m)
      }
      |> Enum.into(preferences)

    create(conn, Map.put(params, "preferences", pref))
  end

  def show(conn, %{"id" => id}) do
    pref = TravelPrefApi.get_pref!(id)
    render(conn, "show.json", travel_pref: pref)
  end

  def update(conn, %{"id" => id, "travel_pref" => params}) do
    pref = TravelPrefApi.get_pref!(id)

    with {:ok, %TravelPref{} = pref_} <-
           TravelPrefApi.update_pref(
             pref,
             params
           ) do
      render(conn, "show.json", travel_pref: pref_)
    end
  end

  def delete(conn, %{"id" => id}) do
    pref = TravelPrefApi.get_pref!(id)

    with {:ok, %TravelPref{}} <- TravelPrefApi.delete_pref(pref) do
      send_resp(conn, :no_content, "")
    end
  end
end
