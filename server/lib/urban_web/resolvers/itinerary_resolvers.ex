defmodule UrbanWeb.ItineraryResolver do
  alias Urban.ItineraryApi, as: Api

  def image_url(it, _, _) do
    {is_local, url} = Api.make_url(it)

    {:ok,
     %{
       is_local: is_local,
       url: url
     }}
  end

  def itineraries(_root, _args, _info) do
    {:ok, Api.list()}
  end

  def x_random_itineraries(_root, %{how_many: how_many} = _args, _info) do
    its = Api.x_random_itineraries(how_many)
    {:ok, its}
  end
end
