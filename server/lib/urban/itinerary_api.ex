defmodule Urban.ItineraryApi do
  @moduledoc """
  The Itinerarys context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo
  alias Urban.Itinerary
  alias Urban.Attachment

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
    change = Itinerary.changeset_no_image(%Itinerary{}, params)

    Repo.transaction(fn ->
      with {:ok, it1} <- Repo.insert(change),
           {:ok, it2} <- Itinerary.changeset(it1, params) |> Repo.update() do
        it2
      else
        {:error, changeset} ->
          Repo.rollback(changeset)
          {:error, changeset}
      end
    end)
    |> case do
      {:ok, it} ->
        {:ok, it}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, %{changeset | action: :insert}}
    end
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
      :image
    ]
  end

  @doc """
  From the image attribute of an itirenary, make the image url and attach it
  to the itinerary. The itinerary is returned as a map
  """
  def make_image_url(%Itinerary{} = it) do
    it
    |> Map.from_struct()
    |> make_image_url()
  end

  def make_image_url(%{image: image} = it) do
    url = Attachment.url({image, it})
    Map.put(it, :image_url, url)
  end
end
