defmodule UrbanWeb.Router do
  use UrbanWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
  end

  pipeline :api do
    plug(:accepts, ["json", "html"])
  end

  scope "/api", UrbanWeb do
    pipe_through(:api)

    resources("/bot_users", BotUserController, except: [:new, :edit])

    resources(
      "/bot_interactions",
      BotInteractionController,
      except: [:new, :edit]
    )

    get("/validate_activities", ValidationController, :validate_activities)
    get("/validate_purposes", ValidationController, :validate_purposes)
    post("/validate_all", ValidationController, :validate_all)
  end

  scope "/", UrbanWeb do
    pipe_through(:browser)

    get("/", ValidationController, :index)
  end
end
