defmodule UrbanWeb.ItineraryController do
  use UrbanWeb, :controller

  alias Urban.ItineraryApi, as: Api
  alias Urban.Itinerary

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    its = Api.list()
    render(conn, "index.json", its: its)
  end

  def create(conn, %{"it" => params}) do
    with {:ok, %Itinerary{} = it} <- Api.create_it(params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", itinerary_path(conn, :show, it))
      |> render("show.json", it: it)
    end
  end

  def show(conn, %{"id" => id}) do
    itinerary = Api.get!(id)
    render(conn, "show.json", it: itinerary)
  end

  def update(conn, %{"id" => id, "it" => params}) do
    it = Api.get!(id)

    with {:ok, %Itinerary{} = it} <- Api.update_it(it, params) do
      render(conn, "show.json", it: it)
    end
  end

  def delete(conn, %{"id" => id}) do
    itinerary = Api.get!(id)

    with {:ok, %Itinerary{}} <- Api.delete_it(itinerary) do
      send_resp(conn, :no_content, "")
    end
  end

  # makes testing easier without the shuffle
  def user_itineraries(conn, %{"start" => _start, "shuffle" => false}) do
    {first, next_its} =
      Api.ids()
      |> Enum.take(10)
      |> Api.compute_itineraries()

    render(conn, "show.json", first_it: first, next_it_ids: next_its)
  end

  def user_itineraries(conn, %{"start" => "true"} = params) do
    user_itineraries(conn, Map.put(params, "start", true))
  end

  def user_itineraries(conn, %{"start" => true}) do
    {first, next_its} =
      Api.ids()
      |> Enum.shuffle()
      |> Enum.take(10)
      |> Api.compute_itineraries()

    render(conn, "show.json", first_it: first, next_it_ids: next_its)
  end

  def user_itineraries(conn, %{"next_itinerary_ids" => nil}) do
    render(conn, "show.json", first_it: nil)
  end

  def user_itineraries(conn, %{"next_itinerary_ids" => ""}) do
    render(conn, "show.json", first_it: nil)
  end

  def user_itineraries(conn, %{"next_itinerary_ids" => next}) when is_list(next) do
    {first, next_its} = Api.compute_itineraries(next)
    render(conn, "show.json", first_it: first, next_it_ids: next_its)
  end

  def user_itineraries(conn, %{"next_itinerary_ids" => next} = params) when is_binary(next) do
    next = Poison.decode!(next)
    params = Map.put(params, "next_itinerary_ids", next)
    user_itineraries(conn, params)
  end
end
