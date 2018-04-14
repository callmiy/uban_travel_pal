defmodule Urban.ItinerarysTest do
  use Urban.DataCase

  alias Urban.ItineraryApi, as: Api
  alias Urban.Itinerary

  @storage Application.get_env(:urban, :arc_storage_dir)

  setup_all context do
    on_exit(context, fn -> File.rm_rf!(@storage) end)
  end

  test "list/0 returns all itinerarys" do
    itinerary = make_it()

    assert Api.list() == [itinerary]
  end

  test "get!/1 returns the itinerary with given id" do
    itinerary = make_it()

    assert Api.get!(itinerary.id) == itinerary
  end

  test "create_it/1 with valid data creates a itinerary" do
    attrs = build(:itinerary) |> Map.from_struct()

    assert {:ok, %Itinerary{id: _} = it} = Api.create_it(attrs)
    assert attrs.image.filename == it.image.file_name
    assert attrs.title == it.title
    assert attrs.description == it.description
  end

  test "create_it/1 with invalid data returns error changeset" do
    attrs = %{title: nil}
    assert {:error, %Ecto.Changeset{}} = Api.create_it(attrs)
  end

  test "update_it/2 with valid data updates the itinerary" do
    it1 = make_it()

    assert {
             :ok,
             %Itinerary{} = it2
           } = Api.update_it(it1, %{title: "updated title"})

    assert it1.id == it2.id
    refute it1.title == it2.title
  end

  test "update_it/2 with invalid data returns error changeset" do
    itinerary = make_it()

    assert {:error, %Ecto.Changeset{}} = Api.update_it(itinerary, %{title: nil})
    assert itinerary == Api.get!(itinerary.id)
  end

  test "delete_it/1 deletes the itinerary" do
    itinerary = make_it()

    assert {:ok, %Itinerary{}} = Api.delete_it(itinerary)
    assert_raise Ecto.NoResultsError, fn -> Api.get!(itinerary.id) end
  end

  test "change_it/1 returns a itinerary changeset" do
    itinerary = make_it()

    assert %Ecto.Changeset{} = Api.change_it(itinerary)
  end

  defp make_it do
    {:ok, %Itinerary{} = it} =
      :itinerary
      |> build()
      |> Map.from_struct()
      |> Api.create_it()

    it
  end
end
