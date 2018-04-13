defmodule Urban.BotUserApi do
  @moduledoc """
  The BotUsers context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo

  alias Urban.BotUser

  @doc """
  Returns the list of bot_users.

  ## Examples

      iex> list_bot_users()
      [%BotUser{}, ...]

  """
  def list_bot_users do
    Repo.all(BotUser)
  end

  @doc """
  Gets a single bot_user.

  Raises `Ecto.NoResultsError` if the Bot user does not exist.

  ## Examples

      iex> get_bot_user!(123)
      %BotUser{}

      iex> get_bot_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bot_user!(id), do: Repo.get!(BotUser, id)

  @doc """
  Creates a bot_user.

  ## Examples

      iex> create_bot_user(%{field: value})
      {:ok, %BotUser{}}

      iex> create_bot_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bot_user(attrs \\ %{}) do
    %BotUser{}
    |> BotUser.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get bot user by attributes.

  ## Examples

      iex> get_by(%{field: value})
      %BotUser{}

      iex> get_by(%{field: bad_value})
      nil

  """
  def get_by(bot_user_id: nil) do
    nil
  end

  def get_by(attrs) do
    Repo.get_by(BotUser, attrs)
  end

  @doc """
  Updates a bot_user.

  ## Examples

      iex> update_bot_user(bot_user, %{field: new_value})
      {:ok, %BotUser{}}

      iex> update_bot_user(bot_user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bot_user(%BotUser{} = bot_user, attrs) do
    bot_user
    |> BotUser.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BotUser.

  ## Examples

      iex> delete_bot_user(bot_user)
      {:ok, %BotUser{}}

      iex> delete_bot_user(bot_user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bot_user(%BotUser{} = bot_user) do
    Repo.delete(bot_user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bot_user changes.

  ## Examples

      iex> change_bot_user(bot_user)
      %Ecto.Changeset{source: %BotUser{}}

  """
  def change_bot_user(%BotUser{} = bot_user) do
    BotUser.changeset(bot_user, %{})
  end
end
