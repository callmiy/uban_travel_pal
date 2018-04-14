defmodule UrbanWeb.Router do
  use UrbanWeb, :router
  use ExAdmin.Router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json", "html"])
  end

  scope "/api/admin", UrbanWeb.ExAdmin do
    pipe_through(:browser)

    post("/itineraries", ItineraryAdminController, :create)
  end

  scope "/api/admin", ExAdmin do
    pipe_through(:browser)
    admin_routes()
  end

  scope "/api", UrbanWeb do
    pipe_through(:api)

    resources("/bot_users", BotUserController, except: [:new, :edit])

    resources(
      "/bot_interactions",
      BotInteractionController,
      except: [:new, :edit]
    )

    resources(
      "/travel_prefs",
      TravelPrefController,
      except: [:new, :edit]
    )

    resources(
      "/itineraries",
      ItineraryController,
      except: [:new, :edit]
    )

    post("/validate_activities", ValidationController, :validate_activities)
    post("/validate_purposes", ValidationController, :validate_purposes)
  end

  scope "/", UrbanWeb do
    pipe_through(:browser)

    get("/", ValidationController, :index)
  end
end
