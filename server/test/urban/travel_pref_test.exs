defmodule Urban.TravelPrefTest do
  use Urban.DataCase

  alias Urban.TravelPrefApi, as: Api
  alias Urban.TravelPref
  alias Urban.TravelPrefTestHelper, as: Helper

  test "list_pref/0 returns all travel_prefs" do
    {params, _interaction} = Helper.make_params()

    {:ok, pref} = Api.create_pref(params)
    assert Api.list_pref() == [pref]
  end

  test "get_pref!/1 returns the travel_pref with given id" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)
    assert Api.get_pref!(pref.id) == pref
  end

  test "create_pref/1 with valid data creates a travel_pref" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)
    assert Helper.validate_attrs_equal(Map.from_struct(pref), params)
  end

  test "create_pref/1 with invalid data returns error changeset" do
    {params, _interaction} = Helper.make_params(%{budget: nil})
    assert {:error, %Ecto.Changeset{}} = Api.create_pref(params)
  end

  test "update_pref/2 with valid data updates the travel_pref" do
    pref = insert(:travel_pref)
    update_attrs = %{first_time_in_city: false, city: "Berlin"}

    assert {:ok,
            %TravelPref{
              city: "Berlin",
              first_time_in_city: false
            } = pref_} = Api.update_pref(pref, update_attrs)

    refute pref.city == pref_.city
    refute pref.first_time_in_city == pref_.first_time_in_city
    assert pref.id == pref_.id
  end

  test "update_pref/2 with invalid data returns error changeset" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)

    assert {:error, %Ecto.Changeset{}} =
             Api.update_pref(pref, %{
               first_time_in_city: nil,
               city: nil
             })

    assert pref == Api.get_pref!(pref.id)
  end

  test "delete_pref/1 deletes the travel_pref" do
    pref = insert(:travel_pref)

    assert {:ok, %TravelPref{}} = Api.delete_pref(pref)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get_pref!(pref.id)
    end
  end

  test "change_pref/1 returns a travel_pref changeset" do
    assert %Ecto.Changeset{} = Api.change_pref(insert(:travel_pref))
  end
end
