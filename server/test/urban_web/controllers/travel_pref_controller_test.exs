defmodule UrbanWeb.TravelPrefControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.TravelPrefApi, as: Api
  alias Urban.TravelPref
  alias Urban.TravelPrefTestHelper, as: Helper
  alias Urban.Utils

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all travel_prefs", %{conn: conn} do
      conn = get(conn, travel_pref_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create travel preferences" do
    test "renders travel preferences when data is valid", %{conn: conn} do
      {params, _interaction} = Helper.make_params()

      conn =
        post(
          conn,
          travel_pref_path(conn, :create),
          preferences: params
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, travel_pref_path(conn, :show, id))
      data = json_response(conn, 200)["data"]
      assert Helper.validate_attrs_equal(data, params)
    end

    test "renders travel preferences from bot when data is valid", %{conn: conn} do
      activities_str = "[\"Dine in restaurants\",\"Try local cuisine\",\"Guided tours\"]"

      purpose_str = " [\"Travelling Couple\"]"

      {params1, _interaction} =
        Helper.make_params(%{
          meet_locals: "yes",
          tourist_attraction: "yes",
          purpose: activities_str,
          activities: purpose_str
        })

      params2 = %{
        params1
        | meet_locals: true,
          tourist_attraction: true,
          purpose: Utils.json_string_as_object(activities_str),
          activities: Utils.json_string_as_object(purpose_str)
      }

      conn =
        post(
          conn,
          travel_pref_path(conn, :create),
          preferences_str: params1
        )

      data = json_response(conn, 201)["data"]
      assert Helper.validate_attrs_equal(data, params2)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      {invalid_attrs, _interaction} = Helper.make_params(%{city: nil})

      conn =
        post(
          conn,
          travel_pref_path(conn, :create),
          preferences: invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update travel_pref" do
    setup [:create_]

    test "renders travel_pref when data is valid", %{
      conn: conn,
      pref: %TravelPref{id: id} = pref
    } do
      conn =
        put(
          conn,
          travel_pref_path(conn, :update, pref),
          travel_pref: %{city: "Berlin"}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, travel_pref_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "city" => "Berlin"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, pref: pref} do
      conn =
        put(
          conn,
          travel_pref_path(conn, :update, pref),
          travel_pref: %{city: nil}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete travel_pref" do
    setup [:create_]

    test "deletes chosen travel_pref", %{conn: conn, pref: pref} do
      conn = delete(conn, travel_pref_path(conn, :delete, pref))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, travel_pref_path(conn, :show, pref))
      end)
    end
  end

  defp create_(_) do
    {attrs, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(attrs)
    {:ok, pref: pref}
  end
end
