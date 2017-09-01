defmodule Bisignal.Ride.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.Participant


  schema "participants" do
    field :user_id, :id
    field :route_id, :id
    field :location, Geo.Geometry

    timestamps()
  end

  @doc false
  def changeset(%Participant{} = participant, attrs) do
    participant
    |> cast(attrs, [:user_id, :route_id])
    |> validate_required([:user_id, :route_id])
    |> unique_constraint(:user_id, name: :participant_id)
    |> foreign_key_constraint(:route_id)
  end
end
