defmodule Urban.Repo.Migrations.CreateBotUserNameEmails do
  use Ecto.Migration

  def change do
    create table(:bot_user_name_emails) do
      add(:name, :citext, null: false)
      add(:email, :citext, null: false)

      timestamps()
    end

    create(index(:bot_user_name_emails, [:name, :email], unique: true))
  end
end
