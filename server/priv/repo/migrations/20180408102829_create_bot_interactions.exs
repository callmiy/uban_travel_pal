defmodule Urban.Repo.Migrations.CreateBotInteractions do
  use Ecto.Migration

  def change do
    create table(:bot_interactions) do
      add(:response_path, :string, null: false)
      add(:bot_id, :string, null: false)
      add(:bot_connection_id, :string, null: false)
      add(:bot_name, :string, null: false)
      add(:bot_platform, :string, null: false)
      add(:channel_id, :string, null: false)
      add(:datetime, :naive_datetime, null: false)
      add(:metadata, :map, null: false)
      add(:message, :string, null: false)
      add(:message_type, :string, null: false)

      add(
        :bot_user_id,
        references(:bot_users, on_delete: :delete_all),
        null: false
      )

      timestamps()
    end

    create(index(:bot_interactions, [:bot_user_id]))
  end
end
