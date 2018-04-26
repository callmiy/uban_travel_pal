defmodule Urban.BotUserNameEmailApi do
  @moduledoc """
  The XXs context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo

  alias Urban.BotUserNameEmail

  @doc """
  Returns the list of bot_user_name_emails.

  ## Examples

      iex> list()
      [%BotUserNameEmail{}, ...]

  """
  def list do
    Repo.all(BotUserNameEmail)
  end

  @doc """
  Gets a single bot_user_name_email.

  Raises `Ecto.NoResultsError` if the Bot user name email does not exist.

  ## Examples

      iex> get!(123)
      %BotUserNameEmail{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(BotUserNameEmail, id)

  @doc """
  Creates a bot_user_name_email.

  ## Examples

      iex> create_(%{field: value})
      {:ok, %BotUserNameEmail{}}

      iex> create_(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_(attrs \\ %{}) do
    %BotUserNameEmail{}
    |> BotUserNameEmail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bot_user_name_email.

  ## Examples

      iex> update_(bot_user_name_email, %{field: new_value})
      {:ok, %BotUserNameEmail{}}

      iex> update_(bot_user_name_email, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_(%BotUserNameEmail{} = bot_user_name_email, attrs) do
    bot_user_name_email
    |> BotUserNameEmail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BotUserNameEmail.

  ## Examples

      iex> delete_(bot_user_name_email)
      {:ok, %BotUserNameEmail{}}

      iex> delete_(bot_user_name_email)
      {:error, %Ecto.Changeset{}}

  """
  def delete_(%BotUserNameEmail{} = bot_user_name_email) do
    Repo.delete(bot_user_name_email)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bot_user_name_email changes.

  ## Examples

      iex> change_(bot_user_name_email)
      %Ecto.Changeset{source: %BotUserNameEmail{}}

  """
  def change_(%BotUserNameEmail{} = bot_user_name_email) do
    BotUserNameEmail.changeset(bot_user_name_email, %{})
  end
end
