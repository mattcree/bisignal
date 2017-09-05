defmodule Bisignal.Ride.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.Participant

  @derive {Poison.Encoder, only: [:user_id, :route_id, :loc_accuracy, :geo_json]}
  schema "participants" do
    field :user_id, :id
    field :route_id, :id
    field :location, Geo.Geometry
    field :loc_accuracy, :float
    field :geo_json, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(%Participant{} = participant, attrs) do
    participant
    |> cast(attrs, [:user_id, :route_id, :location, :loc_accuracy, :updated_at])
    |> validate_required([:user_id, :route_id])
    |> unique_constraint(:user_id, name: :participant_id)
    |> foreign_key_constraint(:route_id)
  end

  def encode_model(geometry) do
    %Participant{geometry | geo_json: Geo.JSON.encode(geometry.location) }
  end

  defimpl Poison.Encoder, for: Bisignal.Ride.Participant do
    def encode(geometry, options) do
      geometry = Participant.encode_model(geometry)
      Poison.Encoder.Map.encode(Map.take(geometry, [:user_id, :route_id, :geo_json, :loc_accuracy]), options)
    end
  end
end
