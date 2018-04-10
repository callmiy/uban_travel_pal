defmodule Urban.TravelPrefTestHelper do
  import Urban.Factory
  alias Urban.Utils

  @attrs [
    :activities,
    :budget,
    :city,
    :meet_locals,
    :plan_type,
    :purpose,
    :tourist_attraction
    # :bot_interaction
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

  def validate_attrs_equal(map1, map2) do
    Utils.validate_keys_vals_equal(@attrs, map1, map2)
  end
end
