defmodule Bisignal.Ride.Waypoint do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.Waypoint


  schema "waypoints" do
    field :waypoint, Geo.Geometry
    field :waypoint_number, :integer
    field :route_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Waypoint{} = waypoint, attrs) do
    waypoint
    |> cast(attrs, [:waypoint_number, :waypoint])
    |> validate_required([:waypoint_number, :waypoint])
  end
end
