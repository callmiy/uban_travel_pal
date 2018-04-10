defmodule Urban.Utils do
  @unregex_patterns_replacement [
    {~r/"\s*\[/, "["},
    {~r/\]"/, "]"},
    {~r/\\/, ""}
  ]

  def list_comma_separated_with_and([]) do
    ""
  end

  def list_comma_separated_with_and(data) when is_list(data) and length(data) == 1 do
    List.first(data)
  end

  def list_comma_separated_with_and(data) when is_list(data) do
    [last | rest] = Enum.reverse(data)
    Enum.join(Enum.reverse(rest), ", ") <> " and #{last}"
  end

  def normalize_time(time) do
    %{time | microsecond: {0, 0}}
  end

  def json_string_as_object(string) do
    @unregex_patterns_replacement
    |> Enum.reduce(Poison.encode!(string), fn {regex, replacement}, acc ->
      Regex.replace(regex, acc, replacement, global: true)
    end)
    |> Poison.decode!()
  end

  def yes_no_to_boolean("yes") do
    true
  end

  def yes_no_to_boolean("no") do
    false
  end

  def yes_no_to_boolean(string) do
    string
    |> String.downcase()
    |> yes_no_to_boolean()
  end

  @doc """
  Validates that for each key, the corresponding values in the given maps are
  equal. The keys must be contained in both maps. The idea is one map may
  contain atom keys while the other may contain string keys.

  ## Examples

      iex> validate_keys_vals_equal(
          [:a, :b], %{a: 1, b: 2}, %{"a" => 1, "b" => 2}
        )
      true

      iex> validate_keys_vals_equal(
          [:a, :b], %{a: 1, b: 2}, %{"a" => 1, "b" => 3}
        )
      false
  """

  @spec validate_keys_vals_equal(keys :: [Atom.t()], map1 :: Map.t(), map2 :: Map.t()) :: Map.t()
  def validate_keys_vals_equal(keys, map1, map2) do
    map1_ = map_keys_to_atom(map1)
    map2_ = map_keys_to_atom(map2)

    Enum.all?(keys, fn attr ->
      Map.get(map1_, attr) == Map.get(map2_, attr)
    end)
  end

  defp map_keys_to_atom(map) do
    for {key, val} <- map, into: %{} do
      cond do
        is_atom(key) -> {key, val}
        true -> {String.to_existing_atom(key), val}
      end
    end
  end
end
