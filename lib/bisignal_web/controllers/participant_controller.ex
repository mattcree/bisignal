defmodule BisignalWeb.ParticipantController do
  use BisignalWeb, :controller

  alias Bisignal.Ride
  alias Bisignal.Ride.Participant

  # def index(conn, _params) do
  #   participants = Ride.list_participants()
  #   render(conn, "index.html", participants: participants)
  # end

  # def new(conn, _params) do
  #   changeset = Ride.change_participant(%Participant{})
  #   render(conn, "new.html", changeset: changeset)
  # end
 
  def create(conn, %{"user_id" => user_id, "id" => id}) do
    participant = %{"user_id" => user_id, "route_id" => id}
    case Ride.create_participant(participant) do
      {:ok, participant} ->
        conn
        |> put_flash(:info, "Participant created successfully.")
        |> redirect(to: user_route_detail_path(conn, :user_show, user_id, id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn 
        |> put_flash(:info, "You're already subscribed!")
        |> redirect(to: user_route_detail_path(conn, :user_show, user_id, id))
    end
  end

  # def show(conn, %{"id" => id}) do
  #   participant = Ride.get_participant!(id)
  #   render(conn, "show.html", participant: participant)
  # end

  # def edit(conn, %{"id" => id}) do
  #   participant = Ride.get_participant!(id)
  #   changeset = Ride.change_participant(participant)
  #   render(conn, "edit.html", participant: participant, changeset: changeset)
  # end

  # def update(conn, %{"id" => id, "participant" => participant_params}) do
  #   participant = Ride.get_participant!(id)

  #   case Ride.update_participant(participant, participant_params) do
  #     {:ok, participant} ->
  #       conn
  #       |> put_flash(:info, "Participant updated successfully.")
  #       |> redirect(to: participant_path(conn, :show, participant))
  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "edit.html", participant: participant, changeset: changeset)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   participant = Ride.get_participant!(id)
  #   {:ok, _participant} = Ride.delete_participant(participant)

  #   conn
  #   |> put_flash(:info, "Participant deleted successfully.")
  #   |> redirect(to: participant_path(conn, :index))
  # end
end
