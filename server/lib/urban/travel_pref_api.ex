defmodule Urban.TravelPrefApi do
  @moduledoc """
  The TravelPrefs context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo

  alias Urban.TravelPref

  @doc """
  Returns the list of travel_prefs.

  ## Examples

      iex> list_pref()
      [%TravelPref{}, ...]

  """
  def list_pref do
    Repo.all(TravelPref)
  end

  @doc """
  Gets a single travel_pref.

  Raises `Ecto.NoResultsError` if the Travel preference does not exist.

  ## Examples

      iex> get!(123)
      %TravelPref{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pref!(id), do: Repo.get!(TravelPref, id)

  @doc """
  Creates a travel_pref.

  ## Examples

      iex> create(%{field: value})
      {:ok, %TravelPref{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pref(attrs \\ %{}) do
    %TravelPref{}
    |> TravelPref.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a travel_pref.

  ## Examples

      iex> update(travel_pref, %{field: new_value})
      {:ok, %TravelPref{}}

      iex> update(travel_pref, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pref(%TravelPref{} = travel_pref, attrs) do
    travel_pref
    |> TravelPref.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TravelPref.

  ## Examples

      iex> delete_pref(travel_pref)
      {:ok, %TravelPref{}}

      iex> delete_pref(travel_pref)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pref(%TravelPref{} = travel_pref) do
    Repo.delete(travel_pref)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking travel_pref changes.

  ## Examples

      iex> change_pref(travel_pref)
      %Ecto.Changeset{source: %TravelPref{}}

  """
  def change_pref(%TravelPref{} = travel_pref) do
    TravelPref.changeset(travel_pref, %{})
  end
end
