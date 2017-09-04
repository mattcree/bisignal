defmodule BisignalWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end
  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_location", %{"longitude" => longitude, "latitude" => latitude}, socket) do
    broadcast! socket, "new_location", %{longitude: longitude, latitude: latitude}
    {:noreply, socket}
  end

  def handle_out("new_location", payload, socket) do
    push socket, "new_location", payload
    {:noreply, socket}
  end

end