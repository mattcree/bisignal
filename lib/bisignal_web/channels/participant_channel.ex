defmodule BisignalWeb.ParticipantChannel do
  use Phoenix.Channel
  alias Bisignal.Ride


  def join("participant:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("participant:" <> _private_room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_location", %{"participant" => participant_id,"longitude" => longitude, "latitude" => latitude, "accuracy" => accuracy}, socket) do
    case Ride.get_participant!(participant_id) do
      participant ->
        location = Geo.WKT.decode("POINT(#{longitude} #{latitude})")
        Ride.update_participant(participant, %{location: location, loc_accuracy: accuracy})
        broadcast! socket, "new_location", %{participant: participant_id, longitude: longitude, latitude: latitude, accuracy: accuracy}
        {:noreply, socket}
      nil ->
        {:error, socket}
    end
  end

  def handle_out("new_location", payload, socket) do
    push socket, "new_location", payload
    {:noreply, socket}
  end

end