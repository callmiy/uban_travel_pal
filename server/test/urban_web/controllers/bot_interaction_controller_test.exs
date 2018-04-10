defmodule UrbanWeb.BotInteractionControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.BotInteraction
  alias Urban.BotInteractionHelper, as: Helper
  alias Urban.BotUser

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bot_interactions", %{conn: conn} do
      conn = get(conn, bot_interaction_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bot_interaction" do
    test "renders bot_interaction succeeds when bot user exists", %{
      conn: conn
    } do
      %BotUser{
        id: user_id,
        bot_user_id: bot_user_id,
        user_response_name: user_response_name,
        email: email
      } = insert(:bot_user)

      attrs = Helper.make_params_chat_platform_bot_user(bot_user_id)

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: attrs
        )

      assert %{
               "bot_interaction_id" => _id,
               "id" => ^user_id,
               "bot_user_id" => ^bot_user_id,
               "user_response_name" => ^user_response_name,
               "email" => ^email
             } = json_response(conn, 201)["data"]
    end

    test "renders bot_interaction succeeds when bot user does not exist", %{
      conn: conn
    } do
      bot_user_id = "1234567"
      attrs = Helper.make_params_chat_platform_bot_user(bot_user_id)

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: attrs
        )

      assert %{
               "bot_interaction_id" => _id,
               "bot_user_id" => ^bot_user_id
             } = json_response(conn, 201)["data"]
    end

    test "renders errors due to invalid bot user data", %{conn: conn} do
      attrs = Helper.make_params_chat_platform_bot_user(nil)

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors due to invalid interaction data", %{conn: conn} do
      attrs = Helper.make_params_chat_platform_bot_user("xyz", %{bot_name: nil})

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bot_interaction" do
    setup [:create_]

    test "renders bot_interaction when data is valid", %{
      conn: conn,
      bot_int: %BotInteraction{id: id} = bot_int
    } do
      conn =
        put(
          conn,
          bot_interaction_path(conn, :update, bot_int),
          bot_interaction: %{bot_platform: "yoyo"}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, bot_interaction_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "bot_platform" => "yoyo"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bot_int: bot_int} do
      conn =
        put(
          conn,
          bot_interaction_path(conn, :update, bot_int),
          bot_interaction: %{bot_platform: nil}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bot_interaction" do
    setup [:create_]

    test "deletes chosen bot_interaction", %{conn: conn, bot_int: bot_int} do
      conn = delete(conn, bot_interaction_path(conn, :delete, bot_int))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, bot_interaction_path(conn, :show, bot_int))
      end)
    end
  end

  defp create_(_) do
    {:ok, bot_int: insert(:bot_int)}
  end
end
