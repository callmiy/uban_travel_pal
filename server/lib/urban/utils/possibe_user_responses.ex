defmodule Urban.Utils.PossibleUserResponses do
  import Urban.Utils.Guards

  alias Elixlsx.{Workbook, Sheet}

  @activities_a [
    "Visit museums",
    "Guided tours",
    "Theme based tours",
    "Independent sights",
    "Exploring"
  ]

  @activities_d [
    "Visit local bars",
    "Try local cuisine",
    "Explore night life"
  ]

  @activities_f [
    "Shopping",
    "Dine in restaurants"
  ]

  @activities_d [
    "Visit local bars",
    "Try local cuisine",
    "Explore night life"
  ]

  @activities_f [
    "Shopping",
    "Dine in restaurants"
  ]

  @budget [
    "between 200 and 400",
    "less than 200 euro",
    "more than 400 euro"
  ]

  @meet_locals [
    "yes",
    "no"
  ]

  @plan [
    "plan",
    "Recommendations"
  ]

  @purpose [
    "family trip",
    "travelling couple",
    "Solo trip",
    "with friends",
    "Romantic trip"
  ]

  @tourist_attraction [
    "yes",
    "no"
  ]

  def combine(data) when is_map(data) do
    data
    |> Enum.to_list()
    |> combine()
  end

  def combine([]) do
    []
  end

  def combine([{keya, vals}]) do
    vals
    |> Enum.reduce([], fn v, acc ->
      map = Map.put(%{}, keya, v)
      [map | acc]
    end)
  end

  def combine([{keya, valsa} | rest1]) do
    [{keyb, valsb} | rest2] = rest1

    combined_a_b =
      valsa
      |> Enum.reduce([], fn valsa_v, acc ->
        %{}
        |> Map.put(keya, valsa_v)
        |> combine(acc, valsb, keyb)
      end)

    combine(combined_a_b, rest2)
  end

  def combine(combined, []) do
    combined
  end

  def combine(combined, [{keya, valsa} | rest]) do
    combines =
      combined
      |> Enum.reduce([], fn map, acc ->
        combine(map, acc, valsa, keya)
      end)

    combine(combines, rest)
  end

  defp combine(map, accx, valsb, keyb) when is_map_list_list_atom(map, accx, valsb, keyb) do
    valsb
    |> Enum.reduce(accx, fn valsb_v, acc_ ->
      map_ = Map.put(map, keyb, valsb_v)
      [map_ | acc_]
    end)
  end

  def response_combinations(mode \\ nil) do
    two_activities_combinations = combine_2_activities()

    {acts_3, rest} =
      responses()
      |> combine()
      |> extract_3_activities_from_combinations()

    data =
      [@activities_a, @activities_d, @activities_f]
      |> Enum.map(fn acts -> Enum.map(acts, &[&1]) end)
      |> Enum.concat()
      |> Enum.concat(two_activities_combinations)
      |> Enum.reverse()
      |> Enum.reduce([], fn act, acc ->
        rest
        |> Enum.reduce(acc, fn rest_map, acc_all ->
          [Map.put(rest_map, :activites, act) | acc_all]
        end)
      end)
      |> Enum.concat(acts_3)
      |> Enum.reverse()

    if mode do
      write_data(data, mode)
    end

    data
  end

  defp extract_3_activities_from_combinations(all_combinations) do
    all_combinations
    |> Enum.reduce({[], []}, fn map, {acc_acts, acc_rest} ->
      {acts, rest} =
        map
        |> Map.split([:activities_a, :activities_d, :activities_f])

      all = Map.put(rest, :activites, Map.values(acts))

      {[all | acc_acts], [rest | acc_rest]}
    end)
  end

  defp combine_2_activities do
    [
      [activities_a: @activities_a, activities_d: @activities_d],
      [activities_a: @activities_a, activities_f: @activities_f],
      [activities_d: @activities_d, activities_f: @activities_f]
    ]
    |> Enum.reduce([], fn input, acc ->
      input
      |> Map.new()
      |> combine()
      |> Enum.reduce([], fn map, acc ->
        [Map.values(map) | acc]
      end)
      |> Enum.into(acc)
    end)
  end

  defp write_data(data, :excel) do
    sheet = Sheet.with_name("Sheet 1")
    row = 1

    Stream.resource(
      fn -> {sheet, row} end,
      fn {sheet1, row1} ->
        {sheet2, _} =
          data
          |> Enum.reduce({sheet1, row1}, fn map, {sheet3, row2} ->
            sheet4 =
              sheet3
              |> Sheet.set_at(row2, 0, Enum.join(map.activites, "    |    "))
              |> Sheet.set_at(row2, 0, map.purpose)
              |> Sheet.set_at(row2, 0, map.budget)
              |> Sheet.set_at(row2, 0, map.tourist_attraction)
              |> Sheet.set_at(row2, 0, map.meet_locals)
              |> Sheet.set_at(row2, 0, map.plan)

            # IO.puts("written: #{inspect(map)}")
            {sheet4, row2 + 1}
          end)

        {:halt, sheet2}
      end,
      fn sheet5 ->
        %Workbook{}
        |> Workbook.append_sheet(sheet5)
        |> Elixlsx.write_to("hello.xlsx")
      end
    )
    |> Enum.to_list()
  end

  defp write_data(data, :csv) do
    strings =
      data
      |> Enum.reduce([], fn map, acc ->
        str =
          [
            Enum.join(map.activites, "    |    "),
            map.purpose,
            map.budget,
            map.tourist_attraction,
            map.meet_locals,
            map.plan
          ]
          |> Enum.join(",")

        [str | acc]
      end)

    string =
      [
        Enum.join(
          [
            "Activities",
            "Purpose",
            "Budget",
            "Tourist Attractions",
            "Meet locals",
            "Plan/Recommendation"
          ],
          ","
        )
      ]
      |> Enum.concat(strings)
      |> Enum.join("\n")

    "my-file.csv"
    |> File.open!([:write])
    |> IO.write(string)
  end

  defp responses do
    %{
      activities_a: @activities_a,
      activities_d: @activities_d,
      activities_f: @activities_f,
      budget: @budget,
      meet_locals: @meet_locals,
      plan: @plan,
      purpose: @purpose,
      tourist_attraction: @tourist_attraction
    }
  end
end
