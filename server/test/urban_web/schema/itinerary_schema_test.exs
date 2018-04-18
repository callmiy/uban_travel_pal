defmodule UrbanWeb.ItinerarySchemaTest do
  use Urban.DataCase

  alias UrbanWeb.Schema
  alias UrbanWeb.ItineraryQueries, as: Queries
  alias Urban.ItineraryApi, as: Api
  alias Urban.Itinerary

  @storage Application.get_env(:urban, :arc_storage_dir)

  setup_all context do
    on_exit(context, fn -> File.rm_rf!(@storage) end)
  end

  describe "queries" do
    test "itineraries succeeds" do
      [
        %{
          id: id,
          title: title
        }
      ] = make_its(1)

      id = Integer.to_string(id)

      assert {
               :ok,
               %{
                 data: %{
                   "itineraries" => [
                     %{
                       "id" => ^id,
                       "title" => ^title,
                       "inserted_at" => _,
                       "updated_at" => _,
                       "booking_url" => _,
                       "image" => %{
                         "url" => _,
                         "is_local" => true
                       }
                     }
                   ]
                 }
               }
             } = Absinthe.run(Queries.query(:itineraries), Schema)
    end

    test "x_random_itineraries succeeds" do
      make_its(3)

      assert {
               :ok,
               %{
                 data: %{
                   "xRandomItineraries" => [_, _]
                 }
               }
             } =
               Absinthe.run(
                 Queries.query(:x_random_itineraries),
                 Schema,
                 variables: %{
                   "how_many" => "2"
                 }
               )
    end
  end

  defp make_its(how_many) do
    1..how_many
    |> Enum.map(fn _ ->
      {:ok, %Itinerary{} = it} =
        :itinerary
        |> build()
        |> Map.from_struct()
        |> Api.create_it()

      Map.from_struct(it)
    end)
  end
end
