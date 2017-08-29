defmodule BisignalWeb.Router do
  use BisignalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BisignalWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController do
      get "/route_details", RouteDetailController, :show_by_user
      delete "/route_details", RouteDetailController, :delete_by_user
    end

    resources "/route_details", RouteDetailController

    resources "/waypoints", WaypointController
    resources "/participants", ParticipantController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

end
