defmodule Bisignal.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :user_id, references(:users, on_delete: :nothing)
      add :route_id, references(:route_details, on_delete: :nothing)
      add :location, :geometry

      timestamps()
    end

    create index(:participants, [:user_id])
    create index(:participants, [:route_id])
  end
end
