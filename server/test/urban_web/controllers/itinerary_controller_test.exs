defmodule UrbanWeb.ItineraryControllerTest do
  use UrbanWeb.ConnCase

  # @moduletag :norun

  alias Urban.ItineraryApi, as: Api

  describe "index" do
    test "lists all itinerarys", %{conn: conn} do
      conn = get(conn, itinerary_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create itinerary" do
    test "renders itinerary when data is valid", %{conn: conn} do
      %{
        description: description,
        title: title,
        image: _image
      } = attrs = :itinerary |> build() |> Map.from_struct()

      conn = post(conn, itinerary_path(conn, :create), it: attrs)

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, itinerary_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => ^description,
               "title" => ^title
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, itinerary_path(conn, :create), it: %{title: nil})
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update itinerary" do
    setup [:make_it]

    test "renders itinerary when data is valid", %{conn: conn, it: it} do
      id = it.id
      attr = %{title: "updated title"}
      conn = put(conn, itinerary_path(conn, :update, it), it: attr)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, itinerary_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "title" => "updated title"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, it: it} do
      conn = put(conn, itinerary_path(conn, :update, it), it: %{title: nil})

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete itinerary" do
    setup [:make_it]

    test "deletes chosen itinerary", %{conn: conn, it: it} do
      conn = delete(conn, itinerary_path(conn, :delete, it))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, itinerary_path(conn, :show, it))
      end)
    end
  end

  def make_it(_) do
    {:ok, it} =
      :itinerary
      |> build()
      |> Map.from_struct()
      |> Api.create_it()

    {:ok, it: it}
  end
end
