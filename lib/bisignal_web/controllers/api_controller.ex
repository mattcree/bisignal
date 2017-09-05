defmodule BisignalWeb.ApiController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize
  import Ecto.Query, warn: false

  alias Bisignal.Ride
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Ride.Participant
  alias Bisignal.Accounts
  alias Bisignal.Accounts.User

  def participants(conn, _params) do
  	participants = Ride.list_participants
    render(conn, participants: participants)
  end

  def current(conn, _params) do
  	participants = Ride.get_participants_by_time_since_update(1)
    render(conn, participants: participants)
  end

  def current_by_time(conn, %{"time" => time}) do
    case Integer.parse(time) do
      {interval, ""} ->
        if interval >= 0 do
          participants = Ride.get_participants_by_time_since_update(interval)
          render(conn, participants: participants)
        else
          empty_participants(conn)
        end
      {interval, other_chars} ->
        empty_participants(conn)
      :error ->
        empty_participants(conn)
    end
  end

  def empty_participants(conn), do: render(conn, participants: [])
end