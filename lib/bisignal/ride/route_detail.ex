defmodule Bisignal.Ride.RouteDetail do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.RouteDetail


  schema "route_details" do
    field :name, :string
    field :datetime, :utc_datetime
    field :start, Geo.Geometry
    field :start_name, :string
    field :end, Geo.Geometry
    field :end_name, :string
    belongs_to :user, Bisignal.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(%RouteDetail{} = route_detail, attrs) do
    route_detail
    |> cast(attrs, [:start, :start_name, :end, :end_name, :datetime, :name, :user_id])
    |> validate_required([:start, :end, :datetime, :name, :user_id])
  end
end
