defmodule Bisignal.Ride.RouteDetail do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.RouteDetail


  schema "route_details" do
    field :name, :string
    field :description, :string
    field :datetime, :utc_datetime
    field :start, Geo.Geometry
    field :end, Geo.Geometry
    field :organiser_id, :id

    timestamps()
  end

  @doc false
  def changeset(%RouteDetail{} = route_detail, attrs) do
    route_detail
    |> cast(attrs, [:start, :end, :datetime, :name, :description])
    |> validate_required([:start, :end, :datetime, :name, :description])
  end
end
