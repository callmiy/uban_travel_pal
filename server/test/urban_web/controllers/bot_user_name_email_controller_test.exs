defmodule UrbanWeb.BotUserNameEmailControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.BotUserNameEmail

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all bot_user_name_emails", %{conn: conn} do
      conn = get(conn, bot_user_name_email_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create bot_user_name_email" do
    test "renders bot_user_name_email when data is valid", %{conn: conn} do
      %{email: email, name: name} =
        attrs =
        :bot_user_name_email
        |> build()
        |> Map.from_struct()

      conn =
        post(
          conn,
          bot_user_name_email_path(conn, :create),
          bot: attrs
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, bot_user_name_email_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "email" => email,
               "name" => name
             }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      attrs =
        :bot_user_name_email
        |> build(name: nil)
        |> Map.from_struct()

      conn = post(conn, bot_user_name_email_path(conn, :create), bot: attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bot_user_name_email" do
    setup [:create_]

    test "renders bot_user_name_email when data is valid", %{
      conn: conn,
      bot: %BotUserNameEmail{id: id} = bot
    } do
      conn =
        put(
          conn,
          bot_user_name_email_path(conn, :update, bot),
          bot: %{name: "updated name"}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, bot_user_name_email_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "name" => "updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, bot: bot} do
      conn =
        put(
          conn,
          bot_user_name_email_path(conn, :update, bot),
          bot: %{name: nil}
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bot_user_name_email" do
    setup [:create_]

    test "deletes chosen bot_user_name_email", %{conn: conn, bot: bot} do
      conn = delete(conn, bot_user_name_email_path(conn, :delete, bot))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, bot_user_name_email_path(conn, :show, bot))
      end)
    end
  end

  defp create_(_) do
    {:ok, bot: insert(:bot_user_name_email)}
  end
end
