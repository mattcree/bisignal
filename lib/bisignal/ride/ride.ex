defmodule Bisignal.Ride do
  @moduledoc """
  The Ride context.
  """

  import Ecto.Query, warn: false
  alias Bisignal.Repo

  alias Bisignal.Ride.RouteDetail

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
    Repo.one!(query)
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

  @doc """
  Gets a single route_detail.

  Raises `Ecto.NoResultsError` if the Route detail does not exist.

  ## Examples

      iex> get_route_detail!(123)
      %RouteDetail{}

      iex> get_route_detail!(456)
      ** (Ecto.NoResultsError)

  """
  def get_route_detail!(id), do: Repo.get!(RouteDetail, id)

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

  alias Bisignal.Ride.Waypoint

  @doc """
  Returns the list of waypoints.

  ## Examples

      iex> list_waypoints()
      [%Waypoint{}, ...]

  """
  def list_waypoints do
    Repo.all(Waypoint)
  end

  @doc """
  Gets a single waypoint.

  Raises `Ecto.NoResultsError` if the Waypoint does not exist.

  ## Examples

      iex> get_waypoint!(123)
      %Waypoint{}

      iex> get_waypoint!(456)
      ** (Ecto.NoResultsError)

  """
  def get_waypoint!(id), do: Repo.get!(Waypoint, id)

  @doc """
  Creates a waypoint.

  ## Examples

      iex> create_waypoint(%{field: value})
      {:ok, %Waypoint{}}

      iex> create_waypoint(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_waypoint(attrs \\ %{}) do
    %Waypoint{}
    |> Waypoint.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a waypoint.

  ## Examples

      iex> update_waypoint(waypoint, %{field: new_value})
      {:ok, %Waypoint{}}

      iex> update_waypoint(waypoint, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_waypoint(%Waypoint{} = waypoint, attrs) do
    waypoint
    |> Waypoint.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Waypoint.

  ## Examples

      iex> delete_waypoint(waypoint)
      {:ok, %Waypoint{}}

      iex> delete_waypoint(waypoint)
      {:error, %Ecto.Changeset{}}

  """
  def delete_waypoint(%Waypoint{} = waypoint) do
    Repo.delete(waypoint)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking waypoint changes.

  ## Examples

      iex> change_waypoint(waypoint)
      %Ecto.Changeset{source: %Waypoint{}}

  """
  def change_waypoint(%Waypoint{} = waypoint) do
    Waypoint.changeset(waypoint, %{})
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
