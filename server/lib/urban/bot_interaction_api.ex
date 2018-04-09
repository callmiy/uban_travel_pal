defmodule Urban.BotInteractionApi do
  @moduledoc """
  The BotInteractions context.
  """

  import Ecto.Query, warn: false
  alias Urban.Repo

  alias Urban.BotInteraction

  @doc """
  Returns the list of bot_interactions.

  ## Examples

      iex> list_bot_interactions()
      [%BotInteraction{}, ...]

  """
  def list_bot_interactions do
    Repo.all(BotInteraction)
  end

  @doc """
  Gets a single bot_interaction.

  Raises `Ecto.NoResultsError` if the Bot interaction does not exist.

  ## Examples

      iex> get_bot_interaction!(123)
      %BotInteraction{}

      iex> get_bot_interaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_bot_interaction!(id), do: Repo.get!(BotInteraction, id)

  @doc """
  Creates a bot_interaction.

  ## Examples

      iex> create_bot_interaction(%{field: value})
      {:ok, %BotInteraction{}}

      iex> create_bot_interaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bot_interaction(attrs \\ %{}) do
    %BotInteraction{}
    |> BotInteraction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bot_interaction.

  ## Examples

      iex> update_bot_interaction(bot_interaction, %{field: new_value})
      {:ok, %BotInteraction{}}

      iex> update_bot_interaction(bot_interaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bot_interaction(%BotInteraction{} = bot_interaction, attrs) do
    bot_interaction
    |> BotInteraction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BotInteraction.

  ## Examples

      iex> delete_bot_interaction(bot_interaction)
      {:ok, %BotInteraction{}}

      iex> delete_bot_interaction(bot_interaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bot_interaction(%BotInteraction{} = bot_interaction) do
    Repo.delete(bot_interaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bot_interaction changes.

  ## Examples

      iex> change_bot_interaction(bot_interaction)
      %Ecto.Changeset{source: %BotInteraction{}}

  """
  def change_bot_interaction(%BotInteraction{} = bot_interaction) do
    BotInteraction.changeset(bot_interaction, %{})
  end
end
