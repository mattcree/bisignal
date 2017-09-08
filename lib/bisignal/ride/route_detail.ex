defmodule Bisignal.Ride.RouteDetail do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.RouteDetail

  @derive {Poison.Encoder, only: [:name, :datetime, :start_name, :end_name, :start, :end]}
  schema "route_details" do
    field :name, :string
    field :datetime, :utc_datetime
    field :start, Geo.Geometry
    field :start_json, :string, virtual: true
    field :start_name, :string
    field :end, Geo.Geometry
    field :end_json, :string, virtual: true
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

  def encode_model(geometry) do
    %RouteDetail{geometry | start: Geo.JSON.encode(geometry.start), end: Geo.JSON.encode(geometry.end) }
  end

  defimpl Poison.Encoder, for: Bisignal.Ride.RouteDetail do
    def encode(geometry, options) do
      IO.inspect "POISON IS DOING SHIT RITE NOW"
      geometry = RouteDetail.encode_model(geometry)
      Poison.Encoder.Map.encode(Map.take(geometry, [:name, :datetime, :start, :end, :start_name, :end_name]), options)
    end
  end
end
