defmodule UrbanWeb.ValidationController do
  use UrbanWeb, :controller
  alias Urban.Utils

  @unwanted ["Skip", "More options"]

  @unregex_patterns_replacement [
    {~r/"\s*\[/, "["},
    {~r/\]"/, "]"},
    {~r/\\/, ""}
  ]

  @purpose_sing_plural [
    "the purpose of your trip is",
    "the purposes of your trip are"
  ]

  @activity_sing_plural [
    "activity is",
    "activities are"
  ]

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  def validate_activities(conn, %{"activities" => activities}) do
    validate(conn, activities, :activities, @activity_sing_plural)
  end

  def validate_purposes(conn, %{"purposes" => purposes}) do
    validate(conn, purposes, :purposes, @purpose_sing_plural)
  end

  def store_preferences(conn, %{"preferences" => preferences}) do
    data =
      @unregex_patterns_replacement
      |> Enum.reduce(Poison.encode!(preferences), fn {regex, replacement}, acc ->
        Regex.replace(regex, acc, replacement, global: true)
      end)
      |> Poison.decode!()

    render(
      conn,
      "validate.json",
      responses: data
    )
  end

  defp validate(conn, params, prefix, singular_plural) do
    values =
      params
      |> Map.to_list()
      |> Enum.reduce([], fn {_k, v}, acc ->
        if String.trim(v) != "" && !Enum.member?(@unwanted, v) do
          [v | acc]
        else
          acc
        end
      end)

    len = length(values)

    {correct, statement} =
      if len < 1 do
        {false, nil}
      else
        spelling =
          if len == 1 do
            List.first(singular_plural)
          else
            List.last(singular_plural)
          end

        data = Utils.list_comma_separated_with_and(values)
        {true, "#{spelling}: #{data}"}
      end

    result =
      %{
        correct: correct,
        len: len,
        statement: statement
      }
      |> Map.put(prefix, values)

    render(
      conn,
      "validate.json",
      responses: result
    )
  end
end
