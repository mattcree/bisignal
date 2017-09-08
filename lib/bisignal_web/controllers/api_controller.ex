defmodule BisignalWeb.ApiController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize
  import Ecto.Query, warn: false

  alias Bisignal.Ride

  # PARTICIPANT API FUNCTIONS

  def participants(conn, _params) do
  	participants = Ride.list_participants
    render(conn, participants: participants)
  end

  def current(conn, _params) do
  	participants = Ride.get_participants_by_time_since_update(5)
    render(conn, participants: participants)
  end

  def current_by_time(conn, %{"time" => time}) do
    case Integer.parse(time) do
      {interval, ""} ->
        if interval >= 0 do
          participants = Ride.get_participants_by_time_since_update(interval)
          render(conn, participants: participants)
        else
          empty_json(conn)
        end
      _ ->
        empty_json(conn)
    end
  end

  def nearby(conn, %{"lng" => lng, "lat" => lat}) do
    case scrub_lng_lat(lng, lat) do
      :error ->
        empty_json(conn)
      {longitude, latitude} ->
        participants = Ride.get_participants_by_distance_from_location(longitude, latitude, 5000)
        render(conn, participants: participants)
    end
  end

  def nearby_current(conn, %{"lng" => lng, "lat" => lat}) do
    case scrub_lng_lat(lng, lat) do
      :error ->
        empty_json(conn)
      {longitude, latitude} ->
        participants = Ride.get_participants_by_time_since_update_and_location(longitude, latitude, 5, 5000)
        render(conn, participants: participants)
    end
  end

  def within_distance(conn, %{"distance" => distance, "lng" => lng, "lat" => lat}) do
    case Integer.parse(distance) do
      {dist, ""} ->
        case scrub_lng_lat(lng, lat) do
          {longitude, latitude} ->
            participants = Ride.get_participants_by_distance_from_location(longitude, latitude, dist)
            render(conn, participants: participants)
          _ ->
            empty_json(conn)
        end
      _ ->
        :error
    end
  end

    def within_distance_by_time(conn, %{"distance" => distance, "lng" => lng, "lat" => lat, "time" => time}) do
    case Integer.parse(distance) do
      {dist, ""} ->
        case Integer.parse(time) do
          {a_time, ""} ->
            case scrub_lng_lat(lng, lat) do
              {longitude, latitude} ->
                participants = Ride.get_participants_by_time_since_update_and_location(longitude, latitude, a_time, dist)
                render(conn, participants: participants)
              _ ->
                empty_json(conn)
        end
          _ ->
            :error
        end
      _ ->
        :error
    end
  end

  def routes_nearby(conn, %{"lng" => lng, "lat" => lat}) do
    case scrub_lng_lat(lng, lat) do
      :error ->
        empty_json(conn)
      {longitude, latitude} ->
        route_details = Ride.get_routes_by_distance_from_location(lng, lat, 5000)
        render(conn, route_details: route_details)
    end
  end

  def routes_within_distance(conn, %{"distance" => distance, "lng" => lng, "lat" => lat}) do
    case Integer.parse(distance) do
      {dist, ""} ->
        case scrub_lng_lat(lng, lat) do
          {longitude, latitude} ->
            route_details = Ride.get_routes_by_distance_from_location(longitude, latitude, dist)
            render(conn, route_details: route_details)
          _ ->
            empty_json(conn)
        end
      _ ->
        :error
    end
  end

  def scrub_lng_lat(lng, lat) do
    {longitude, valid_long} = parse_coord(lng, &is_within_range/3, -180.0, 180.0)
    {latitude, valid_lat} = parse_coord(lat, &is_within_range/3, -90.0, 90.0)
    if (valid_long == true and valid_lat == true) do
      IO.inspect {longitude, latitude}
      {longitude, latitude}
    else
      :error
    end
  end

  def parse_coord(coord, validate, lower, upper) do
    case Float.parse(coord) do
      {coord, ""} ->
        {coord, validate.(coord, lower, upper)}
      :error ->
        {0, false}
    end
  end

  def is_within_range(num, lower, upper), do: num >= lower and num <= upper
  def empty_json(conn), do: render(conn, participants: [])


  # ROUTE DETAILS API FUNCTIONS

  def routes(conn, _params) do
    routes = Ride.list_route_details
    render(conn, routes: routes)
  end


end