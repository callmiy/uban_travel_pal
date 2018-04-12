defmodule Urban.UtilsPossibleUserResponseTest do
  use ExUnit.Case
  alias Urban.Utils.PossibleUserResponses

  test "get all possible user responses" do
    PossibleUserResponses.response_combinations()
    |> IO.inspect()
  end
end
