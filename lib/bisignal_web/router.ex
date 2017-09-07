defmodule BisignalWeb.Router do
  use BisignalWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Phauxth.Authenticate
    plug :put_user_token
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BisignalWeb do
    pipe_through :api

    get "/participants_all", ApiController, :participants
    get "/participants_current", ApiController, :current
    get "/participants_current/:time", ApiController, :current_by_time
    get "/participants_near/:lng/:lat", ApiController, :nearby
    get "/participants_within/:distance/meters_of/:lng/:lat", ApiController, :within_distance

    get "/routes_all", ApiController, :routes
    get "/routes_near/:lng/:lat", ApiController, :routes_nearby
    get "/routes_within/:distance/of/:lng/:lat", ApiController, :routes_within_distance
  end

  scope "/", BisignalWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :new, :create, :delete, :show] do
      get "/participation", ParticipantController, :show_by_user
      get "/participation/:id", ParticipantController, :show
      get "/route_details", RouteDetailController, :show_by_user
      get "/route_details/new", RouteDetailController, :new
      get "/route_details/:id", RouteDetailController, :user_show
      post "/route_details/", RouteDetailController, :create
      delete "/route_details/:id", RouteDetailController, :delete_by_user 
    end

    get "/route_details/:id", RouteDetailController, :show
    get "/route_details/", RouteDetailController, :index
    post "/route_details/:id/join", ParticipantController, :create
    delete "/route_details/:id/leave", ParticipantController, :delete
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end

end
