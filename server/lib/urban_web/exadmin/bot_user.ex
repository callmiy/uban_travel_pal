defmodule UrbanWeb.ExAdmin.BotUser do
  use ExAdmin.Register

  register_resource Urban.BotUser do
    show bot_user do
      attributes_table()

      panel "Bot Interactions" do
        table_for(bot_user.bot_interactions) do
          column(:id)
          column(:datetime)
        end
      end
    end
  end
end
