defmodule UrbanWeb.ItineraryControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.Itinerarys
  alias Urban.Itinerarys.Itinerary

  @create_attrs %{description: "some description", image: "some image", title: "some title"}
  @update_attrs %{description: "some updated description", image: "some updated image", title: "some updated title"}
  @invalid_attrs %{description: nil, image: nil, title: nil}

  def fixture(:itinerary) do
    {:ok, itinerary} = Itinerarys.create_itinerary(@create_attrs)
    itinerary
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all itinerarys", %{conn: conn} do
      conn = get conn, itinerary_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create itinerary" do
    test "renders itinerary when data is valid", %{conn: conn} do
      conn = post conn, itinerary_path(conn, :create), itinerary: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, itinerary_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some description",
        "image" => "some image",
        "title" => "some title"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, itinerary_path(conn, :create), itinerary: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update itinerary" do
    setup [:create_itinerary]

    test "renders itinerary when data is valid", %{conn: conn, itinerary: %Itinerary{id: id} = itinerary} do
      conn = put conn, itinerary_path(conn, :update, itinerary), itinerary: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, itinerary_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "description" => "some updated description",
        "image" => "some updated image",
        "title" => "some updated title"}
    end

    test "renders errors when data is invalid", %{conn: conn, itinerary: itinerary} do
      conn = put conn, itinerary_path(conn, :update, itinerary), itinerary: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete itinerary" do
    setup [:create_itinerary]

    test "deletes chosen itinerary", %{conn: conn, itinerary: itinerary} do
      conn = delete conn, itinerary_path(conn, :delete, itinerary)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, itinerary_path(conn, :show, itinerary)
      end
    end
  end

  defp create_itinerary(_) do
    itinerary = fixture(:itinerary)
    {:ok, itinerary: itinerary}
  end
end
