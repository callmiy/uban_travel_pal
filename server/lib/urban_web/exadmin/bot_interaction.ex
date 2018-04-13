defmodule UrbanWeb.ExAdmin.BotInteraction do
  use ExAdmin.Register

  register_resource Urban.BotInteraction do
    show bot_int do
      attributes_table()

      panel "Bot User" do
        IO.inspect(bot_int)

        table_for(bot_int.bot_user) do
          column(:user_response_name)
        end
      end
    end

    query do
      %{
        all: [
          preload: [:bot_user]
        ]
      }
    end
  end
end
