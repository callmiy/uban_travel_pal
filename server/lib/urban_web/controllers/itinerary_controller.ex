defmodule UrbanWeb.ItineraryController do
  use UrbanWeb, :controller

  alias Urban.ItineraryApi, as: Api
  alias Urban.Itinerary

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    itinerarys = Api.list_itinerarys()
    render(conn, "index.json", itinerarys: itinerarys)
  end

  def create(conn, %{"itinerary" => itinerary_params}) do
    with {:ok, %Itinerary{} = itinerary} <- Api.create_itinerary(itinerary_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", itinerary_path(conn, :show, itinerary))
      |> render("show.json", itinerary: itinerary)
    end
  end

  def show(conn, %{"id" => id}) do
    itinerary = Api.get_itinerary!(id)
    render(conn, "show.json", itinerary: itinerary)
  end

  def update(conn, %{"id" => id, "itinerary" => itinerary_params}) do
    itinerary = Api.get_itinerary!(id)

    with {:ok, %Itinerary{} = itinerary} <- Api.update_itinerary(itinerary, itinerary_params) do
      render(conn, "show.json", itinerary: itinerary)
    end
  end

  def delete(conn, %{"id" => id}) do
    itinerary = Api.get_itinerary!(id)

    with {:ok, %Itinerary{}} <- Api.delete_itinerary(itinerary) do
      send_resp(conn, :no_content, "")
    end
  end
end
