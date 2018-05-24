# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Urban.Repo.insert!(%Urban.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Urban.ItineraryApi, as: Api

csv_file = "/home/kanmii/Downloads/itineraries.csv"
image_dir = "/media/kanmii/Windows/Users/maneptha/Desktop/itineraries"

csv_file
|> File.stream!()
|> CSV.decode!(headers: true)
|> Stream.map(fn %{"Image" => image} = it ->
  %{"file_name" => file_name} = Poison.decode!(image)
  path = Path.join(image_dir, file_name)

  image = %Plug.Upload{
    filename: file_name,
    path: path
  }

  it =
    it
    |> Map.drop(["Inserted At", "Updated At", "Image", "Id"])
    |> Enum.reduce(%{}, fn {k, v}, acc ->
      k =
        k
        |> String.downcase()
        |> String.replace(" ", "_")

      Map.put(acc, k, v)
    end)
    |> Map.put("image", image)

  Api.create_it(it)
end)
|> Enum.to_list()
