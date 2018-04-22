defmodule UrbanWeb.TravelPrefController do
  use UrbanWeb, :controller

  alias Urban.TravelPrefApi, as: Api
  alias Urban.TravelPref
  alias Urban.Utils

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    travel_prefs = Api.list_pref()
    render(conn, "index.json", travel_prefs: travel_prefs)
  end

  def create(conn, %{"preferences" => _params} = params) do
    with {:ok, pref, conn} <- create_conn(conn, params) do
      render(conn, "show.json", travel_pref: pref)
    end
  end

  def create(conn, %{"preferences_str" => prefs} = params) do
    pref = normalize_prefs_from_chat(prefs)
    params = Map.put(params, "preferences", pref)

    with {:ok, pref, conn} <- create_conn(conn, params) do
      render(conn, "show.json", travel_pref: pref)
    end
  end

  def show(conn, %{"id" => id}) do
    pref = Api.get_pref!(id)
    render(conn, "show.json", travel_pref: pref)
  end

  def update(conn, %{"id" => id, "travel_pref" => params}) do
    pref = Api.get_pref!(id)

    with {:ok, %TravelPref{} = pref_} <-
           Api.update_pref(
             pref,
             params
           ) do
      render(conn, "show.json", travel_pref: pref_)
    end
  end

  def delete(conn, %{"id" => id}) do
    pref = Api.get_pref!(id)

    with {:ok, %TravelPref{}} <- Api.delete_pref(pref) do
      send_resp(conn, :no_content, "")
    end
  end

  defp create_conn(conn, %{"preferences" => params}) do
    with {:ok, pref} <- Api.create_pref(params) do
      conn =
        conn
        |> put_status(:created)
        |> put_resp_header(
          "location",
          travel_pref_path(conn, :show, pref)
        )

      {:ok, pref, conn}
    end
  end

  defp normalize_prefs_from_chat(prefs) do
    %{
      "activities" => a,
      "first_time_in_city" => f
    } = prefs

    %{
      "activities" => Utils.json_string_as_object(a),
      "first_time_in_city" => Utils.yes_no_to_boolean(f)
    }
    |> Enum.into(prefs)
  end
end
