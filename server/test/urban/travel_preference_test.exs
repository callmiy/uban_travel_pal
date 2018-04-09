defmodule Urban.TravelPreferenceTest do
  use Urban.DataCase

  alias Urban.TravelPreferenceApi, as: Api
  alias Urban.TravelPreference
  alias Urban.TravelPreferenceTestHelper, as: Helper

  test "list_pref/0 returns all travel_preferences" do
    {params, _interaction} = Helper.make_params()

    {:ok, pref} = Api.create_pref(params)
    assert Api.list_pref() == [pref]
  end

  test "get_pref!/1 returns the travel_preference with given id" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)
    assert Api.get_pref!(pref.id) == pref
  end

  test "create_pref/1 with valid data creates a travel_preference" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)

    assert pref.activities == params.activities
    assert pref.budget == params.budget
    assert pref.city == params.city
    assert pref.meet_locals == params.meet_locals
    assert pref.plan_type == params.plan_type
    assert pref.purpose == params.purpose
    assert pref.tourist_attraction == params.tourist_attraction
  end

  test "create_pref/1 with invalid data returns error changeset" do
    {params, _interaction} = Helper.make_params(%{budget: nil})
    assert {:error, %Ecto.Changeset{}} = Api.create_pref(params)
  end

  test "update_pref/2 with valid data updates the travel_preference" do
    pref = insert(:travel_pref)
    update_attrs = %{meet_locals: false, city: "Berlin"}

    assert {:ok,
            %TravelPreference{
              city: "Berlin",
              meet_locals: false
            } = pref_} = Api.update_pref(pref, update_attrs)

    refute pref.city == pref_.city
    refute pref.meet_locals == pref_.meet_locals
    assert pref.id == pref_.id
  end

  test "update_pref/2 with invalid data returns error changeset" do
    {params, _interaction} = Helper.make_params()
    {:ok, pref} = Api.create_pref(params)

    assert {:error, %Ecto.Changeset{}} =
             Api.update_pref(pref, %{
               meet_locals: nil,
               city: nil
             })

    assert pref == Api.get_pref!(pref.id)
  end

  test "delete_pref/1 deletes the travel_preference" do
    pref = insert(:travel_pref)

    assert {:ok, %TravelPreference{}} = Api.delete_pref(pref)

    assert_raise Ecto.NoResultsError, fn ->
      Api.get_pref!(pref.id)
    end
  end

  test "change_pref/1 returns a travel_preference changeset" do
    assert %Ecto.Changeset{} = Api.change_pref(insert(:travel_pref))
  end
end
