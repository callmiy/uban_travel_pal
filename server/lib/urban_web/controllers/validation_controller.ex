defmodule UrbanWeb.ValidationController do
  use UrbanWeb, :controller

  @unwanted ["Skip", "More options"]

  @unregex_patterns_replacement [
    {~r/"\s*\[/, "["},
    {~r/\]"/, "]"},
    {~r/\\/, ""}
  ]

  action_fallback(UrbanWeb.FallbackController)

  def index(conn, _params) do
    conn
    |> put_layout(false)
    |> render("index.html")
  end

  defp validate(conn, params, prefix, entity) do
    values =
      params
      |> Map.to_list()
      |> Enum.reduce([], fn {k, v}, acc ->
        if String.starts_with?(k, prefix) && String.trim(v) != "" && !Enum.member?(@unwanted, v) do
          [v | acc]
        else
          acc
        end
      end)

    len = length(values)
    correct = if len < 1, do: false, else: true

    render(
      conn,
      "validate.json",
      responses: %{correct: correct} |> Map.put(entity, values)
    )
  end

  def validate_activities(conn, params) do
    validate(conn, params, "act", :activities)
  end

  def validate_purposes(conn, params) do
    validate(conn, params, "purpose", :purposes)
  end

  def validate_all(conn, params) do
    data =
      @unregex_patterns_replacement
      |> Enum.reduce(Poison.encode!(params), fn {regex, replacement}, acc ->
        Regex.replace(regex, acc, replacement, global: true)
      end)
      |> Poison.decode!()

    render(
      conn,
      "validate.json",
      responses: data
    )
  end
end
