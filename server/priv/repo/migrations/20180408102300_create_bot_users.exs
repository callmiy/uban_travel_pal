defmodule Urban.Repo.Migrations.CreateBotUsers do
  use Ecto.Migration

  def change do
    create table(:bot_users) do
      add(:bot_user_id, :string, null: false)
      add(:user_response_name, :string)
      add(:email, :string)

      timestamps()
    end

    create(index(:bot_users, [:bot_user_id, :email], unique: true))
  end
end
