defmodule Urban.Utils do
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
end
