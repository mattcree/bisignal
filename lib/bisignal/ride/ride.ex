defmodule Bisignal.Ride do
  @moduledoc """
  The Ride context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Bisignal.Repo
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Ride.Participant
  alias Bisignal.Accounts.User

  def list_users_routes(user_id) do
    query = from ride in RouteDetail, where: ride.user_id == ^user_id, order_by: [desc: ride.datetime]
    Repo.all(query)
  end

  def get_users_route_detail(user_id, id) do
    query = from ride in RouteDetail, where: ride.user_id == ^user_id and ride.id == ^id, order_by: [desc: ride.datetime]
    Repo.one(query)
  end

  def list_route_details do
    query = from ride in RouteDetail, order_by: [desc: ride.datetime]
    Repo.all(query)
  end

  def get_routes_by_distance_from_location(lng, lat, distance) do
    location = Geo.WKT.decode("POINT(#{lng} #{lat})")
    query = from route in RouteDetail, 
            where: st_dwithin_in_meters(route.start, ^location, ^distance) 
                or st_dwithin_in_meters(route.end, ^location, ^distance)
    Repo.all(query)
  end

  def get_route_detail!(id), do: Repo.get(RouteDetail, id)

  def create_route_detail(attrs \\ %{}) do
    %RouteDetail{}
    |> RouteDetail.changeset(attrs)
    |> Repo.insert()
  end

  def update_route_detail(%RouteDetail{} = route_detail, attrs) do
    route_detail
    |> RouteDetail.changeset(attrs)
    |> Repo.update()
  end

  def delete_route_detail(%RouteDetail{} = route_detail) do
    Repo.delete(route_detail)
  end

  def change_route_detail(%RouteDetail{} = route_detail) do
    RouteDetail.changeset(route_detail, %{})
  end

  def list_participants do
    Repo.all(Participant)
  end

  def get_participant!(id), do: Repo.get!(Participant, id)

  def get_participant_names(route_id) do
    query = from u in User,
              join: p in Participant, where: u.id==p.user_id and p.route_id==^route_id, select: u.name
    Repo.all(query)
  end

  def get_participant_by_route_and_user(user_id, route_id) do
    query = from p in Participant, where: p.user_id==^user_id and p.route_id==^route_id
    Repo.all(query)
  end

  def get_participation_by_user(user_id) do
    query = from r in RouteDetail,
              join: p in Participant, where: p.user_id==^user_id and r.id==p.route_id
    Repo.all(query)
  end

  def get_participants_by_time_since_update(time) when time >= 0 and is_integer(time)  do
    interval = time - (time * 2)
    query = from p in Participant, where: p.updated_at > datetime_add(^Ecto.DateTime.utc, ^interval, "minute")
    Repo.all(query)
  end

  def get_participants_by_time_since_update_and_location(lng, lat, time, distance) when time >= 0 and is_integer(time)  do
    interval = time - (time * 2)
    location = Geo.WKT.decode("POINT(#{lng} #{lat})")
    query = from p in Participant, where: p.updated_at > datetime_add(^Ecto.DateTime.utc, ^interval, "minute") 
                                      and st_dwithin_in_meters(p.location, ^location, ^distance)
    Repo.all(query)
  end

  def get_participants_by_distance_from_location(lng, lat, distance) do
    location = Geo.WKT.decode("POINT(#{lng} #{lat})")
    query = from participant in Participant, where: st_dwithin_in_meters(participant.location, ^location, ^distance)
    Repo.all(query)
  end

  def create_participant(attrs \\ %{}) do
    %Participant{}
    |> Participant.changeset(attrs)
    |> Repo.insert()
  end

  def update_participant(%Participant{} = participant, attrs) do
    participant
    |> Participant.changeset(attrs)
    |> Repo.update()
  end

  def delete_participant(%Participant{} = participant) do
    Repo.delete(participant)
  end

  def change_participant(%Participant{} = participant) do
    Participant.changeset(participant, %{})
  end
end
