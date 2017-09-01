defmodule Bisignal.Repo.Migrations.CreateParticipants do
  use Ecto.Migration

  def change do
    create table(:participants) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :route_id, references(:route_details, on_delete: :delete_all)
      add :location, :geometry

      timestamps()
    end

    create unique_index(:participants, [:user_id, :route_id], name: :participant_id)
  end
end
