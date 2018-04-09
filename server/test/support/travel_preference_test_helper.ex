defmodule Urban.TravelPreferenceTestHelper do
  import Urban.Factory

  @attrs [
    :activities,
    :budget,
    :city,
    :meet_locals,
    :plan_type,
    :purpose,
    :tourist_attraction,
    :bot_interaction
  ]

  def make_params(attrs \\ %{}) do
    interaction = insert(:bot_int)

    params =
      build(
        :travel_pref,
        Enum.into(attrs, %{bot_interaction_id: interaction.id})
      )
      |> Map.from_struct()

    {params, interaction}
  end

  def validate_attrs_equal(attrs, data_1, data_2) do
    Enum.all?(attrs, fn attr ->
      Map.get(data_1, attr) == Map.get(data_2, attr)
    end)
  end
end
