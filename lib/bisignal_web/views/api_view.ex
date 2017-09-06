defmodule BisignalWeb.ApiView do
  use BisignalWeb, :view

  #PARTICIPANT API VIEW
  def render("participants.json", %{participants: participants}) do
    participants
  end

  def render("current.json", %{participants: participants}) do
    participants
  end

  def render("current_by_time.json", %{participants: participants}) do
    participants
  end

  def render("nearby.json", %{participants: participants}) do
    participants
  end

  def render("within_distance.json", %{participants: participants}) do
    participants
  end

  #ROUTE DETAILS API VIEW
  def render("routes.json", %{routes: routes}) do
    routes
  end

end