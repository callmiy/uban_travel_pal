defmodule UrbanWeb.TravelPreferenceControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.TravelPreferenceApi, as: Api
  alias Urban.TravelPreference
  alias Urban.TravelPreferenceTestHelper, as: Helper

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all travel_preferences", %{conn: conn} do
      conn = get(conn, travel_preference_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create travel_preference" do
    test "renders travel_preference when data is valid", %{conn: conn} do
      {params, _interaction} = Helper.make_params()

      conn =
        post(
          conn,
          travel_preference_path(conn, :create),
          travel_preference: params
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, travel_preference_path(conn, :show, id))
      data = json_response(conn, 200)["data"]
      assert Helper.validate_attrs_equal(data, params)
    end

    # test "renders errors when data is invalid", %{conn: conn} do
    #   conn = post(conn, travel_preference_path(conn, :create), travel_preference: @invalid_attrs)
    #   assert json_response(conn, 422)["errors"] != %{}
    # end
  end

  # describe "update travel_preference" do
  #   setup [:create]

  #   test "renders travel_preference when data is valid", %{
  #     conn: conn,
  #     travel_preference: %TravelPreference{id: id} = travel_preference
  #   } do
  #     conn =
  #       put(
  #         conn,
  #         travel_preference_path(conn, :update, travel_preference),
  #         travel_preference: @update_attrs
  #       )

  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, travel_preference_path(conn, :show, id))

  #     assert json_response(conn, 200)["data"] == %{
  #              "id" => id,
  #              "activities" => [],
  #              "budget" => "some updated budget",
  #              "city" => "some updated city",
  #              "meet_locals" => false,
  #              "plan_type" => "some updated plan_type",
  #              "purpose" => [],
  #              "tourist_attraction" => false
  #            }
  #   end

  #   test "renders errors when data is invalid", %{
  #     conn: conn,
  #     travel_preference: travel_preference
  #   } do
  #     conn =
  #       put(
  #         conn,
  #         travel_preference_path(conn, :update, travel_preference),
  #         travel_preference: @invalid_attrs
  #       )

  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete travel_preference" do
  #   setup [:create]

  #   test "deletes chosen travel_preference", %{conn: conn, travel_preference: travel_preference} do
  #     conn = delete(conn, travel_preference_path(conn, :delete, travel_preference))
  #     assert response(conn, 204)

  #     assert_error_sent(404, fn ->
  #       get(conn, travel_preference_path(conn, :show, travel_preference))
  #     end)
  #   end
  # end
end
