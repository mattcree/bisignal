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

  scope "/", BisignalWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/users", UserController, only: [:index, :new, :create, :delete, :show] do
      get "/route_details", RouteDetailController, :show_by_user
      get "/route_details/new", RouteDetailController, :new
      get "/route_details/:id", RouteDetailController, :user_show
      get "/participation", ParticipantController, :show_by_user
      get "/participation/:id", ParticipantController, :show
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
