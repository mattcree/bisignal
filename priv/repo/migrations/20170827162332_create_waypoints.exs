defmodule Bisignal.Repo.Migrations.CreateWaypoints do
  use Ecto.Migration

  def change do
    create table(:waypoints) do
      add :waypoint_number, :integer
      add :waypoint, :geometry
      add :route_id, references(:route_details, on_delete: :nothing)

      timestamps()
    end

    create index(:waypoints, [:route_id])
  end
end
