defmodule UrbanWeb.BotInteractionControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.BotInteractionApi, as: Api
  alias Urban.BotInteraction
  alias Urban.BotInteractionHelper, as: Helper
  alias Urban.BotUser

  @basic_formatter "{ISO:Extended:Z}"

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
      } = Helper.create_bot_user()

      valid_attrs_no_user =
        Map.put(
          Helper.valid_attrs_no_user(),
          :user_id,
          bot_user_id
        )

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: valid_attrs_no_user
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

      attrs =
        Map.put(
          Helper.valid_attrs_no_user(),
          :user_id,
          bot_user_id
        )

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
      attrs =
        Map.put(
          Helper.invalid_attrs_with_valid_user_id(),
          :user_id,
          nil
        )

      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders errors due to invalid interaction data", %{conn: conn} do
      conn =
        post(
          conn,
          bot_interaction_path(conn, :create),
          bot_interaction: Helper.invalid_attrs_with_valid_user_id()
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update bot_interaction" do
    setup [:create_bot_interaction]

    test "renders bot_interaction when data is valid", %{
      conn: conn,
      bot_interaction: %BotInteraction{id: id} = bot_interaction
    } do
      update_attrs = Helper.update_attrs()

      conn =
        put(
          conn,
          bot_interaction_path(conn, :update, bot_interaction),
          bot_interaction: update_attrs
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, bot_interaction_path(conn, :show, id))

      assert json_response(conn, 200)["data"] == %{
               "id" => id,
               "bot_connection_id" => update_attrs.bot_connection_id,
               "bot_id" => update_attrs.bot_id,
               "bot_name" => update_attrs.bot_name,
               "bot_platform" => update_attrs.bot_platform,
               "channel_id" => update_attrs.channel_id,
               "datetime" =>
                 Timex.format!(
                   update_attrs.datetime,
                   @basic_formatter
                 ),
               "message" => update_attrs.message,
               "message_type" => update_attrs.message_type,
               "metadata" => update_attrs.metadata,
               "response_path" => update_attrs.response_path
             }
    end

    test "renders errors when data is invalid", %{conn: conn, bot_interaction: bot_interaction} do
      conn =
        put(
          conn,
          bot_interaction_path(conn, :update, bot_interaction),
          bot_interaction: Helper.invalid_attrs()
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete bot_interaction" do
    setup [:create_bot_interaction]

    test "deletes chosen bot_interaction", %{conn: conn, bot_interaction: bot_interaction} do
      conn = delete(conn, bot_interaction_path(conn, :delete, bot_interaction))
      assert response(conn, 204)

      assert_error_sent(404, fn ->
        get(conn, bot_interaction_path(conn, :show, bot_interaction))
      end)
    end
  end

  defp create_bot_interaction(_) do
    {:ok, bot_interaction} = Api.create_bot_interaction(Helper.valid_attrs())
    {:ok, bot_interaction: bot_interaction}
  end
end
