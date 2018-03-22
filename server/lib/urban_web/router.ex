defmodule UrbanWeb.Router do
  use UrbanWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", UrbanWeb do
    pipe_through :api
  end
end
