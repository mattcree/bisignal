defmodule Bisignal.Repo.Migrations.CreateRouteDetails do
  use Ecto.Migration

  def change do
    create table(:route_details) do
      add :start, :geometry
      add :start_name, :string
      add :end, :geometry
      add :end_name, :string
      add :datetime, :utc_datetime
      add :name, :string
      add :description, :string
      add :user_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:route_details, [:user_id])
  end
end
