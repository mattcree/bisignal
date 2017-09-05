defmodule BisignalWeb.ParticipantChannel do
  use Phoenix.Channel

  def join("participant:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("participant:" <> _private_room_id, _params, socket) do
    {:ok, socket}
  end

  def handle_in("new_location", %{"participant" => participant,"longitude" => longitude, "latitude" => latitude, "accuracy" => accuracy}, socket) do
    IO.inspect "====================="
    IO.inspect " User: #{socket.assigns.user}"
    IO.inspect "====================="
    broadcast! socket, "new_location", %{participant: participant, longitude: longitude, latitude: latitude, accuracy: accuracy}
    {:noreply, socket}
  end

  def handle_out("new_location", payload, socket) do
    push socket, "new_location", payload
    {:noreply, socket}
  end

end