defmodule BisignalWeb.RouteDetailController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize
  import Ecto.Query, warn: false

  alias Bisignal.Ride
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Accounts.User
  alias Bisignal.Accounts

  plug :user_check when action in [:new, :user_show]
  plug :user_id_check when action in [:create, :edit, :update, :delete_by_user, :show_by_user]

  def index(conn, _params) do
    route_details = Ride.list_route_details()
    render(conn, "list_index.html", route_details: route_details)
  end

  def new(conn, _params) do
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
    case Ride.get_users_route_detail(user_id, id) do
      nil ->
        conn
        |> put_flash(:info, "No Route Found")
        |> redirect(to: page_path(conn, :index))
      route_detail ->
        user = Accounts.get(user_id)
        participants = Ride.get_participant_names(id)
        render(conn, "user_show.html", route_detail: route_detail, participants: participants, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    case Ride.get_route_detail!(id) do
      nil ->
        conn
        |> put_flash(:info, "No Route Found")
        |> redirect(to: route_detail_path(conn, :index))
      route_detail ->
        participants = Ride.get_participant_names(id)
        render(conn, "show.html", route_detail: route_detail, participants: participants)
    end
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
    |> redirect(to: user_path(conn, :show, user_id))
  end
end
