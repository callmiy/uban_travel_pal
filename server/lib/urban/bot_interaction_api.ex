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

      iex> list()
      [%BotInteraction{}, ...]

  """
  def list do
    Repo.all(BotInteraction)
  end

  @doc """
  Gets a single bot_interaction.

  Raises `Ecto.NoResultsError` if the Bot interaction does not exist.

  ## Examples

      iex> get!(123)
      %BotInteraction{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(BotInteraction, id)

  @doc """
  Creates a bot_interaction.

  ## Examples

      iex> create_bot_int(%{field: value})
      {:ok, %BotInteraction{}}

      iex> create_bot_int(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_bot_int(attrs \\ %{}) do
    %BotInteraction{}
    |> BotInteraction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a bot_interaction.

  ## Examples

      iex> update_bot_int(bot_interaction, %{field: new_value})
      {:ok, %BotInteraction{}}

      iex> update_bot_int(bot_interaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_bot_int(%BotInteraction{} = bot_interaction, attrs) do
    bot_interaction
    |> BotInteraction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a BotInteraction.

  ## Examples

      iex> delete_bot_int(bot_interaction)
      {:ok, %BotInteraction{}}

      iex> delete_bot_int(bot_interaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_bot_int(%BotInteraction{} = bot_interaction) do
    Repo.delete(bot_interaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking bot_interaction changes.

  ## Examples

      iex> change_bot_int(bot_interaction)
      %Ecto.Changeset{source: %BotInteraction{}}

  """
  def change_bot_int(%BotInteraction{} = bot_interaction) do
    BotInteraction.changeset(bot_interaction, %{})
  end

  def attributes do
    [
      :bot_connection_id,
      :bot_id,
      :bot_name,
      :bot_platform,
      :channel_id,
      :datetime,
      :message,
      :message_type,
      :metadata,
      :response_path
    ]
  end

  def test_metadat do
    %{
      "firstTimeUser" => true,
      "browserName" => "Chrome Mobile",
      "browserVersion" => "65.0.3325.181",
      "operatingSystem" => "Android",
      "operatingSystemVersion" => "5.0",
      "deviceProduct" => "Galaxy S5",
      "mobile" => true
    }
  end
end
