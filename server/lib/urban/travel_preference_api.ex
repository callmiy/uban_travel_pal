defmodule Urban.TravelPreferenceApi do
  @moduledoc """
  The TravelPreferences context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo

  alias Urban.TravelPreference

  @doc """
  Returns the list of travel_preferences.

  ## Examples

      iex> list_pref()
      [%TravelPreference{}, ...]

  """
  def list_pref do
    Repo.all(TravelPreference)
  end

  @doc """
  Gets a single travel_preference.

  Raises `Ecto.NoResultsError` if the Travel preference does not exist.

  ## Examples

      iex> get!(123)
      %TravelPreference{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pref!(id), do: Repo.get!(TravelPreference, id)

  @doc """
  Creates a travel_preference.

  ## Examples

      iex> create(%{field: value})
      {:ok, %TravelPreference{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pref(attrs \\ %{}) do
    %TravelPreference{}
    |> TravelPreference.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a travel_preference.

  ## Examples

      iex> update(travel_preference, %{field: new_value})
      {:ok, %TravelPreference{}}

      iex> update(travel_preference, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pref(%TravelPreference{} = travel_preference, attrs) do
    travel_preference
    |> TravelPreference.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a TravelPreference.

  ## Examples

      iex> delete_pref(travel_preference)
      {:ok, %TravelPreference{}}

      iex> delete_pref(travel_preference)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pref(%TravelPreference{} = travel_preference) do
    Repo.delete(travel_preference)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking travel_preference changes.

  ## Examples

      iex> change_pref(travel_preference)
      %Ecto.Changeset{source: %TravelPreference{}}

  """
  def change_pref(%TravelPreference{} = travel_preference) do
    TravelPreference.changeset(travel_preference, %{})
  end
end
