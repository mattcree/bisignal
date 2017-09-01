defmodule BisignalWeb.RouteDetailController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize
  alias Bisignal.Ride
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Accounts.User
  alias Bisignal.Accounts
  import Ecto.Query, warn: false

  plug :user_check when action in [:index, :show]
  plug :user_id_check when action in [:edit, :update, :delete_by_user, :show_by_user]

  def index(conn, _params) do
    route_details = Ride.list_route_details()
    render(conn, "list_index.html", route_details: route_details)
  end

  def new(conn, _params) do
    IO.inspect "wot"
    changeset = Ride.change_route_detail(%RouteDetail{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user_id" => user_id, "route_detail" => route_detail_params}) do
    assoc_user = Map.put(route_detail_params, "user_id", user_id)
    case Ride.create_route_detail(assoc_user) do
      {:ok, route_detail} ->
        user = Accounts.get(user_id)
        conn
        |> put_flash(:info, "Route detail created successfully.")
        |> redirect(to: user_route_detail_path(conn, :user_show, user, route_detail))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def user_show(conn, %{"user_id" => user_id,"id" => id}) do
    user = Accounts.get(user_id)
    route_detail = Ride.get_users_ride(user_id, id)
    render(conn, "user_show.html", route_detail: route_detail, user: user)
  end

  def show(conn, %{"id" => id}) do
    route_detail = Ride.get_route_detail!(id)
    render(conn, "show.html", route_detail: route_detail)
  end

  def show_by_user(conn, %{"user_id" => user_id}) do
    route_details = Ride.list_users_routes(user_id)
    user = Accounts.get(user_id)
    render(conn, "user_index.html", route_details: route_details, user: user)
  end

  def delete_by_user(conn, %{"user_id" => user_id, "id" => id}) do
    route_detail = Ride.get_route_detail!(id)
    {:ok, _route_detail} = Ride.delete_route_detail(route_detail)
    conn
    |> put_flash(:info, "Route detail deleted successfully.")
    |> redirect(to: user_route_detail_path(conn, :show_by_user, user_id))
  end

end
