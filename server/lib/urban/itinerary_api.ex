defmodule Urban.ItineraryApi do
  @moduledoc """
  The Itinerarys context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo
  alias Urban.Itinerary
  alias Urban.Attachment

  @storage_dir Application.get_env(:urban, :arc_storage_dir)
  @storage_dir_prefix_pattern ~r/^\/[^\/]+/

  @doc """
  Returns the list of itinerarys.

  ## Examples

      iex> list_itinerarys()
      [%Itinerary{}, ...]

  """
  def list do
    Repo.all(Itinerary)
  end

  @doc """
  Gets a single itinerary.

  Raises `Ecto.NoResultsError` if the Itinerary does not exist.

  ## Examples

      iex> get!(123)
      %Itinerary{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Itinerary, id)

  @doc """
  Creates a itinerary.

  ## Examples

      iex> create_it(%{field: value})
      {:ok, %Itinerary{}}

      iex> create_it(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """

  def create_it(params \\ %{}) do
    %Itinerary{}
    |> Itinerary.changeset(params)
    |> Repo.insert()
  end

  @doc """
  Updates a itinerary.

  ## Examples

      iex> update_it(itinerary, %{field: new_value})
      {:ok, %Itinerary{}}

      iex> update_it(itinerary, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_it(%Itinerary{} = itinerary, attrs) do
    itinerary
    |> Itinerary.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Itinerary.

  ## Examples

      iex> delete_it(itinerary)
      {:ok, %Itinerary{}}

      iex> delete_it(itinerary)
      {:error, %Ecto.Changeset{}}

  """
  def delete_it(%Itinerary{} = itinerary) do
    Repo.delete(itinerary)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking itinerary changes.

  ## Examples

      iex> change_it(itinerary)
      %Ecto.Changeset{source: %Itinerary{}}

  """
  def change_it(%Itinerary{} = itinerary) do
    Itinerary.changeset(itinerary, %{})
  end

  def required_params do
    [
      :title,
      :description,
      :image,
      :booking_url
    ]
  end

  @doc """
  From the image attribute of an itirenary, make the image url and attach it
  to the itinerary. The itinerary is returned as a map
  """
  def make_image_url(it) do
    {local, url} = make_url(it)

    it
    |> Map.from_struct()
    |> Enum.into(%{image_url: url, local: local})
  end

  def make_url(%{image: image} = it, strip_prefix \\ true) do
    url = Attachment.url({image, it})

    # for testing purpose: in production, url starts with
    # "https://...@storage_dir", but in local, starts with "/@storage_dir"

    {is_local, url_} =
      if String.starts_with?(url, "/#{@storage_dir}") do
        # strip the prefix from the url for requests coming from chatbot as this
        # is already part of the chatbot url in the frontend
        # may it is not such a good idea to have the frontend contain some that
        # varies like the url prefix i.e instead of http://abc.com/api
        # I should simply leave it as http://abc.com. This is more robust
        {true, String.replace(url, @storage_dir_prefix_pattern, "")}
      else
        {false, url}
      end

    if strip_prefix do
      {is_local, url_}
    else
      {is_local, url}
    end
  end

  @doc """
  Get all travel preference ID
  """
  def ids do
    Repo.all(
      from(
        t in Itinerary,
        select: t.id
      )
    )
  end

  def get_by_ids(ids) do
    Repo.all(
      from(
        t in Itinerary,
        where: t.id in ^ids
      )
    )
  end

  @doc """
  Given a list of itinerary IDs, return the first full itinerary and
  only IDs for the rest.
  Return "nil" if empty
  """
  def compute_itineraries(it_ids) do
    case it_ids do
      [] ->
        {nil, nil}

      [first | rest] ->
        first_with_url =
          first
          |> get!()
          |> make_image_url()

        rest_returned =
          case rest do
            [] ->
              nil

            rest_ ->
              rest_
          end

        {first_with_url, rest_returned}
    end
  end

  def x_random_itineraries(how_many) when is_binary(how_many) do
    how_many
    |> String.to_integer()
    |> x_random_itineraries()
  end

  def x_random_itineraries(how_many) when is_integer(how_many) do
    ids()
    |> Enum.shuffle()
    |> Enum.take(how_many)
    |> get_by_ids()
    |> Enum.shuffle()
  end
end
