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

    get "/participants", ApiController, :participants
    get "/participants/:time", ApiController, :current_by_time
    get "/participants_recent", ApiController, :current
    get "/participants_recent_near/:lng/:lat", ApiController, :nearby_current
    get "/participants_last_seen_near/:lng/:lat", ApiController, :nearby
    get "/participants_last_seen/:distance/meters_from/:lng/:lat", ApiController, :within_distance
    get "/participants/:distance/meters_from/:lng/:lat/in_last/:time/minutes", ApiController, :within_distance_by_time

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
