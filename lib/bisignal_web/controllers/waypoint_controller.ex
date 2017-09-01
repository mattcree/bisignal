defmodule BisignalWeb.WaypointController do
  use BisignalWeb, :controller

  alias Bisignal.Ride
  alias Bisignal.Ride.Waypoint

  # def index(conn, _params) do
  #   waypoints = Ride.list_waypoints()
  #   render(conn, "index.html", waypoints: waypoints)
  # end

  # def new(conn, _params) do
  #   changeset = Ride.change_waypoint(%Waypoint{})
  #   render(conn, "new.html", changeset: changeset)
  # end

  # def create(conn, %{"waypoint" => waypoint_params}) do
  #   case Ride.create_waypoint(waypoint_params) do
  #     {:ok, waypoint} ->
  #       conn
  #       |> put_flash(:info, "Waypoint created successfully.")
  #       |> redirect(to: waypoint_path(conn, :show, waypoint))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "new.html", changeset: changeset)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
  #   waypoint = Ride.get_waypoint!(id)
  #   render(conn, "show.html", waypoint: waypoint)
  # end

  # def edit(conn, %{"id" => id}) do
  #   waypoint = Ride.get_waypoint!(id)
  #   changeset = Ride.change_waypoint(waypoint)
  #   render(conn, "edit.html", waypoint: waypoint, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "waypoint" => waypoint_params}) do
  #   waypoint = Ride.get_waypoint!(id)

  #   case Ride.update_waypoint(waypoint, waypoint_params) do
  #     {:ok, waypoint} ->
  #       conn
  #       |> put_flash(:info, "Waypoint updated successfully.")
  #       |> redirect(to: waypoint_path(conn, :show, waypoint))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", waypoint: waypoint, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   waypoint = Ride.get_waypoint!(id)
  #   {:ok, _waypoint} = Ride.delete_waypoint(waypoint)

  #   conn
  #   |> put_flash(:info, "Waypoint deleted successfully.")
  #   |> redirect(to: waypoint_path(conn, :index))
  # end
end
