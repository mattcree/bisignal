defmodule BisignalWeb.ApiView do
  use BisignalWeb, :view

  def render("participants.json", %{participants: participants}) do
    participants
  end

  def render("current.json", %{participants: participants}) do
    participants
  end

  def render("current_by_time.json", %{participants: participants}) do
    participants
  end

end