defmodule UrbanWeb.BotUserControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.BotUserApi
  alias Urban.BotUser
  alias Urban.BotUserTestHelper, as: Helper

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bot_users", %{conn: conn} do
      conn = get(conn, bot_user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bot_user" do
    test "renders bot_user when data is valid", %{conn: conn} do
      valid_attrs = Helper.valid_attrs()

      conn =
        post(
          conn,
          bot_user_path(conn, :create),
          bot_user: Helper.valid_attrs()
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, bot_user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => valid_attrs.email,
               "bot_user_id" => valid_attrs.bot_user_id,
               "user_response_name" => valid_attrs.user_response_name
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn =
        post(
          conn,
          bot_user_path(conn, :create),
          bot_user: Helper.invalid_attrs()
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bot_user" do
    setup [:create_bot_user]

    test "renders bot_user when data is valid", %{
      conn: conn,
      bot_user: %BotUser{id: id} = bot_user
    } do
      update_attrs = Helper.update_attrs()

      conn =
        put(
          conn,
          bot_user_path(conn, :update, bot_user),
          bot_user: update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, bot_user_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => update_attrs.email,
               "bot_user_id" => update_attrs.bot_user_id,
               "user_response_name" => update_attrs.user_response_name
             }
    end

    test "renders errors when data is invalid", %{
      conn: conn,
      bot_user: bot_user
    } do
      conn =
        put(
          conn,
          bot_user_path(conn, :update, bot_user),
          bot_user: Helper.invalid_attrs()
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bot_user" do
    setup [:create_bot_user]

    test "deletes chosen bot_user", %{conn: conn, bot_user: bot_user} do
      conn = delete(conn, bot_user_path(conn, :delete, bot_user))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, bot_user_path(conn, :show, bot_user))
      end)
    end
  end

  defp create_bot_user(_) do
    {:ok, bot_user} = BotUserApi.create_bot_user(Helper.valid_attrs())
    {:ok, bot_user: bot_user}
  end
end
