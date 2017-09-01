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
    resources "/users", UserController, only: [:index, :new, :create, :delete, :show] do
      get "/route_details", RouteDetailController, :show_by_user
      get "/route_details/new", RouteDetailController, :new
      get "/route_details/:id", RouteDetailController, :user_show
      post "/route_details/", RouteDetailController, :create
      delete "/route_details/:id", RouteDetailController, :delete_by_user 
    end

    post "/route_details/:id/join", ParticipantController, :create
    get "/route_details/:id", RouteDetailController, :show
    get "/route_details/", RouteDetailController, :index

    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

end
