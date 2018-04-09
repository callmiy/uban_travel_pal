defmodule Urban.UtilsTest do
  use ExUnit.Case, async: true
  import Urban.Utils

  test "list_comma_separated_with_and/1 succeeds for empty list" do
    assert "" == list_comma_separated_with_and([])
  end

  test "list_comma_separated_with_and/1 succeeds for one member list" do
    assert "yoo" == list_comma_separated_with_and(["yoo"])
  end

  test "list_comma_separated_with_and/1 succeeds for 2 members list" do
    assert "yoo and yah" == list_comma_separated_with_and(["yoo", "yah"])
  end

  test "list_comma_separated_with_and/1 succeeds for 3 members list" do
    assert "yeh, yoo and yah" ==
             list_comma_separated_with_and([
               "yeh",
               "yoo",
               "yah"
             ])
  end
end
