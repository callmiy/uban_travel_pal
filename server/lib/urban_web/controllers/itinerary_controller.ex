defmodule UrbanWeb.ItineraryController do
  use UrbanWeb, :controller

  alias Urban.ItineraryApi, as: Api
  alias Urban.Itinerary

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    itinerarys = Api.list()
    render(conn, "index.json", itinerarys: itinerarys)
  end

  def create(conn, %{"it" => params}) do
    with {:ok, %Itinerary{} = it} <- Api.create_it(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", itinerary_path(conn, :show, it))
      |> render("show.json", itinerary: it)
    end
  end

  def show(conn, %{"id" => id}) do
    itinerary = Api.get!(id)
    render(conn, "show.json", itinerary: itinerary)
  end

  def update(conn, %{"id" => id, "it" => params}) do
    it = Api.get!(id)

    with {:ok, %Itinerary{} = it} <- Api.update_it(it, params) do
      render(conn, "show.json", itinerary: it)
    end
  end

  def delete(conn, %{"id" => id}) do
    itinerary = Api.get!(id)

    with {:ok, %Itinerary{}} <- Api.delete_it(itinerary) do
      send_resp(conn, :no_content, "")
    end
  end
end
