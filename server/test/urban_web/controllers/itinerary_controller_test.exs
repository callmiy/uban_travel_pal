defmodule UrbanWeb.ItineraryControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.ItineraryApi, as: Api

  @storage Application.get_env(:urban, :arc_storage_dir)

  setup_all context do
    on_exit(context, fn -> File.rm_rf!(@storage) end)
  end

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

  describe "user itineraries" do
    test "fetch 1st time with start boolean and 2 itineraries in database", %{conn: conn} do
      [it1, it2] = make_its(2)

      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          start: true,
          shuffle: false
        )

      %{
        "first_itinerary" => first,
        "next_itinerary_ids" => next
      } = json_response(conn, 200)["data"]

      assert it1.id == first["id"]
      assert [it2.id] == next
    end

    test "fetch 1st time with start string and 2 itineraries in database", %{conn: conn} do
      [it1, it2] = make_its(2)

      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          start: "true",
          shuffle: false
        )

      %{
        "first_itinerary" => first,
        "next_itinerary_ids" => next
      } = json_response(conn, 200)["data"]

      assert it1.id == first["id"]
      assert [it2.id] == next
    end

    test "fetch last itinerary with List", %{conn: conn} do
      {:ok, it: it2} = make_it(nil)

      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          next_itinerary_ids: [it2.id]
        )

      assert %{
               "first_itinerary" => first,
               "next_itinerary_ids" => nil
             } = json_response(conn, 200)["data"]

      assert it2.id == first["id"]
    end

    test "fetch last itinerary with binary", %{conn: conn} do
      {:ok, it: it2} = make_it(nil)

      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          next_itinerary_ids: "[#{it2.id}]"
        )

      assert %{
               "first_itinerary" => first,
               "next_itinerary_ids" => nil
             } = json_response(conn, 200)["data"]

      assert it2.id == first["id"]
    end

    test "fetch first time with 3 itineraries in database", %{conn: conn} do
      [it1, it2, it3] = make_its(3)

      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          start: true,
          shuffle: false
        )

      assert %{
               "first_itinerary" => first,
               "next_itinerary_ids" => next
             } = json_response(conn, 200)["data"]

      assert it1.id == first["id"]
      assert [it2.id, it3.id] == next
    end

    test "nothing to fetch called with nil", %{conn: conn} do
      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          next_itinerary_ids: nil
        )

      assert %{
               "first_itinerary" => nil
             } = json_response(conn, 200)["data"]
    end

    test "nothing to fetch called with string", %{conn: conn} do
      conn =
        post(
          conn,
          itinerary_path(conn, :user_itineraries),
          next_itinerary_ids: ""
        )

      assert %{
               "first_itinerary" => nil
             } = json_response(conn, 200)["data"]
    end
  end

  defp make_it(_) do
    {:ok, it} =
      :itinerary
      |> build()
      |> Map.from_struct()
      |> Api.create_it()

    {:ok, it: it}
  end

  defp make_its(how_many) do
    1..how_many
    |> Enum.map(fn _ ->
      {:ok, it: it} = make_it(nil)
      it
    end)
  end
end
