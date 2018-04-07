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

    get("/validate_activities", ValidationController, :validate_activities)
    get("/validate_purposes", ValidationController, :validate_purposes)
    get("/validate_transport", ValidationController, :validate_transport)
    post("/validate_all", ValidationController, :validate_all)
  end

  scope "/", UrbanWeb do
    pipe_through(:browser)

    get("/", ValidationController, :index)
  end
end
