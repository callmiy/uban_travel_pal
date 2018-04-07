defmodule UrbanWeb.ValidationControllerTest do
  use UrbanWeb.ConnCase

  alias Urban.Chatfuel
  alias Urban.Chatfuel.Validation

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

  def fixture(:validation) do
    {:ok, validation} = Chatfuel.create_validation(@create_attrs)
    validation
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all validation", %{conn: conn} do
      conn = get conn, validation_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create validation" do
    test "renders validation when data is valid", %{conn: conn} do
      conn = post conn, validation_path(conn, :create), validation: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, validation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, validation_path(conn, :create), validation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update validation" do
    setup [:create_validation]

    test "renders validation when data is valid", %{conn: conn, validation: %Validation{id: id} = validation} do
      conn = put conn, validation_path(conn, :update, validation), validation: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, validation_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "name" => "some updated name"}
    end

    test "renders errors when data is invalid", %{conn: conn, validation: validation} do
      conn = put conn, validation_path(conn, :update, validation), validation: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete validation" do
    setup [:create_validation]

    test "deletes chosen validation", %{conn: conn, validation: validation} do
      conn = delete conn, validation_path(conn, :delete, validation)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, validation_path(conn, :show, validation)
      end
    end
  end

  defp create_validation(_) do
    validation = fixture(:validation)
    {:ok, validation: validation}
  end
end
