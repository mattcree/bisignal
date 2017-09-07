defmodule Bisignal.Ride do
  @moduledoc """
  The Ride context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS
  alias Bisignal.Repo
  alias Bisignal.Ride.RouteDetail
  alias Bisignal.Accounts.User


  @doc """
  Returns the list of route_details.

  ## Examples

      iex> list_route_details()
      [%RouteDetail{}, ...]

  """
  def list_users_routes(user_id) do
    query = from ride in RouteDetail, where: ride.user_id == ^user_id, order_by: [desc: ride.datetime]
    Repo.all(query)
  end

  def get_users_route_detail(user_id, id) do
    query = from ride in RouteDetail, where: ride.user_id == ^user_id and ride.id == ^id, order_by: [desc: ride.datetime]
    Repo.one(query)
  end

    @doc """
  Returns the list of route_details associated with a user.

  ## Examples

      iex> list_route_details()
      [%RouteDetail{}, ...]

  """
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

  @doc """
  Gets a single route_detail.

  Raises `Ecto.NoResultsError` if the Route detail does not exist.

  ## Examples

      iex> get_route_detail!(123)
      %RouteDetail{}

      iex> get_route_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_route_detail!(id), do: Repo.get(RouteDetail, id)

  @doc """
  Creates a route_detail.

  ## Examples

      iex> create_route_detail(%{field: value})
      {:ok, %RouteDetail{}}

      iex> create_route_detail(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_route_detail(attrs \\ %{}) do
    %RouteDetail{}
    |> RouteDetail.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a route_detail.

  ## Examples

      iex> update_route_detail(route_detail, %{field: new_value})
      {:ok, %RouteDetail{}}

      iex> update_route_detail(route_detail, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_route_detail(%RouteDetail{} = route_detail, attrs) do
    route_detail
    |> RouteDetail.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a RouteDetail.

  ## Examples

      iex> delete_route_detail(route_detail)
      {:ok, %RouteDetail{}}

      iex> delete_route_detail(route_detail)
      {:error, %Ecto.Changeset{}}

  """
  def delete_route_detail(%RouteDetail{} = route_detail) do
    Repo.delete(route_detail)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking route_detail changes.

  ## Examples

      iex> change_route_detail(route_detail)
      %Ecto.Changeset{source: %RouteDetail{}}

  """
  def change_route_detail(%RouteDetail{} = route_detail) do
    RouteDetail.changeset(route_detail, %{})
  end

  alias Bisignal.Ride.Participant

  @doc """
  Returns the list of participants.

  ## Examples

      iex> list_participants()
      [%Participant{}, ...]

  """
  def list_participants do
    Repo.all(Participant)
  end

  @doc """
  Gets a single participant.

  Raises `Ecto.NoResultsError` if the Participant does not exist.

  ## Examples

      iex> get_participant!(123)
      %Participant{}

      iex> get_participant!(456)
      ** (Ecto.NoResultsError)

  """
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

  def get_participants_by_distance_from_location(lng, lat, distance) do
    location = Geo.WKT.decode("POINT(#{lng} #{lat})")
    query = from participant in Participant, where: st_dwithin_in_meters(participant.location, ^location, ^distance)
    Repo.all(query)
  end
  @doc """
  Creates a participant.

  ## Examples

      iex> create_participant(%{field: value})
      {:ok, %Participant{}}

      iex> create_participant(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_participant(attrs \\ %{}) do
    %Participant{}
    |> Participant.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a participant.

  ## Examples

      iex> update_participant(participant, %{field: new_value})
      {:ok, %Participant{}}

      iex> update_participant(participant, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_participant(%Participant{} = participant, attrs) do
    participant
    |> Participant.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Participant.

  ## Examples

      iex> delete_participant(participant)
      {:ok, %Participant{}}

      iex> delete_participant(participant)
      {:error, %Ecto.Changeset{}}

  """
  def delete_participant(%Participant{} = participant) do
    Repo.delete(participant)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking participant changes.

  ## Examples

      iex> change_participant(participant)
      %Ecto.Changeset{source: %Participant{}}

  """
  def change_participant(%Participant{} = participant) do
    Participant.changeset(participant, %{})
  end
end
