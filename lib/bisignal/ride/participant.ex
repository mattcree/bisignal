defmodule Bisignal.Ride.Participant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Bisignal.Ride.Participant


  schema "participants" do
    field :user_id, :id
    field :route_id, :id

    timestamps()
  end

  @doc false
  def changeset(%Participant{} = participant, attrs) do
    participant
    |> cast(attrs, [])
    |> validate_required([])
  end
end
