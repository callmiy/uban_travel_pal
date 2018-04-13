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

  def create_it(%{image: image} = attrs) do
    {:ok, image_base} = Attachment.store({image, %Itinerary{}})

    updated_at =
      Timex.now()
      |> Timex.format!("{ISO:Extended:Z}")
      |> Ecto.DateTime.cast!()

    image = %{
      file_name: image_base,
      updated_at: updated_at
    }

    :itinerary
    |> Urban.Factory.build(%{attrs | image: image})
    |> Repo.insert()
  end

  def create(attrs \\ %{}) do
    %Itinerary{}
    |> Itinerary.changeset(attrs)
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
      :image
    ]
  end
end
