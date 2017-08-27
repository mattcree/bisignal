defmodule Bisignal.Repo.Migrations.CreateRouteDetails do
  use Ecto.Migration

  def change do
    create table(:route_details) do
      add :start, :geometry
      add :end, :geometry
      add :datetime, :utc_datetime
      add :name, :string
      add :description, :string
      add :organiser_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:route_details, [:organiser_id])
  end
end
