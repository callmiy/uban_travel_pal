defmodule Urban.ItinerarysTest do
  use Urban.DataCase

  alias Urban.Itinerarys

  describe "itinerarys" do
    alias Urban.Itinerarys.Itinerary

    @valid_attrs %{description: "some description", image: "some image", title: "some title"}
    @update_attrs %{description: "some updated description", image: "some updated image", title: "some updated title"}
    @invalid_attrs %{description: nil, image: nil, title: nil}

    def itinerary_fixture(attrs \\ %{}) do
      {:ok, itinerary} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Itinerarys.create_itinerary()

      itinerary
    end

    test "list_itinerarys/0 returns all itinerarys" do
      itinerary = itinerary_fixture()
      assert Itinerarys.list_itinerarys() == [itinerary]
    end

    test "get_itinerary!/1 returns the itinerary with given id" do
      itinerary = itinerary_fixture()
      assert Itinerarys.get_itinerary!(itinerary.id) == itinerary
    end

    test "create_itinerary/1 with valid data creates a itinerary" do
      assert {:ok, %Itinerary{} = itinerary} = Itinerarys.create_itinerary(@valid_attrs)
      assert itinerary.description == "some description"
      assert itinerary.image == "some image"
      assert itinerary.title == "some title"
    end

    test "create_itinerary/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Itinerarys.create_itinerary(@invalid_attrs)
    end

    test "update_itinerary/2 with valid data updates the itinerary" do
      itinerary = itinerary_fixture()
      assert {:ok, itinerary} = Itinerarys.update_itinerary(itinerary, @update_attrs)
      assert %Itinerary{} = itinerary
      assert itinerary.description == "some updated description"
      assert itinerary.image == "some updated image"
      assert itinerary.title == "some updated title"
    end

    test "update_itinerary/2 with invalid data returns error changeset" do
      itinerary = itinerary_fixture()
      assert {:error, %Ecto.Changeset{}} = Itinerarys.update_itinerary(itinerary, @invalid_attrs)
      assert itinerary == Itinerarys.get_itinerary!(itinerary.id)
    end

    test "delete_itinerary/1 deletes the itinerary" do
      itinerary = itinerary_fixture()
      assert {:ok, %Itinerary{}} = Itinerarys.delete_itinerary(itinerary)
      assert_raise Ecto.NoResultsError, fn -> Itinerarys.get_itinerary!(itinerary.id) end
    end

    test "change_itinerary/1 returns a itinerary changeset" do
      itinerary = itinerary_fixture()
      assert %Ecto.Changeset{} = Itinerarys.change_itinerary(itinerary)
    end
  end
end
