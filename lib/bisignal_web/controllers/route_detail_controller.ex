defmodule BisignalWeb.RouteDetailController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize
  alias Bisignal.Ride
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Accounts.User
  alias Bisignal.Accounts

  plug :user_check when action in [:index, :show]
  plug :id_check when action in [:edit, :update, :delete]

  def index(conn, _params) do
    route_details = Ride.list_route_details()
    render(conn, "index.html", route_details: route_details, user: nil)
  end

  def new(conn, _params) do
    changeset = Ride.change_route_detail(%RouteDetail{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"route_detail" => route_detail_params}) do
    user = conn.assigns.current_user.id
    assoc_user = Map.put(route_detail_params, "user_id", user)
    case Ride.create_route_detail(assoc_user) do
      {:ok, route_detail} ->
        conn
        |> put_flash(:info, "Route detail created successfully.")
        |> redirect(to: route_detail_path(conn, :show, route_detail))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    route_detail = Ride.get_route_detail!(id)
    render(conn, "show.html", route_detail: route_detail)
  end

  def show_by_user(conn, %{"user_id" => id}) do
    user = Accounts.get(id)
    route_details = Ride.list_users_routes(id)
    render(conn, "index.html", route_details: route_details, user: user)
  end

  def edit(conn, %{"id" => id}) do
    route_detail = Ride.get_route_detail!(id)
    changeset = Ride.change_route_detail(route_detail)
    render(conn, "edit.html", route_detail: route_detail, changeset: changeset)
  end

  def update(conn, %{"id" => id, "route_detail" => route_detail_params}) do
    route_detail = Ride.get_route_detail!(id)
    case Ride.update_route_detail(route_detail, route_detail_params) do
      {:ok, route_detail} ->
        conn
        |> put_flash(:info, "Route detail updated successfully.")
        |> redirect(to: route_detail_path(conn, :show, route_detail))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", route_detail: route_detail, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    route_detail = Ride.get_route_detail!(id)
    {:ok, _route_detail} = Ride.delete_route_detail(route_detail)

    conn
    |> put_flash(:info, "Route detail deleted successfully.")
    |> redirect(to: route_detail_path(conn, :index))
  end

  def delete_by_user(conn, %{"user_id" => id}) do
    ride = Ride.get_route_detail!(id)
    IO.inspect id
    conn
    |> put_flash(:info, "Route detail deleted successfully.")
    |> redirect(to: route_detail_path(conn, :index))
  end

end
