defmodule BisignalWeb.SessionController do
  use BisignalWeb, :controller

  import BisignalWeb.Authorize

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => params}) do
    case Phauxth.Login.verify(params, Bisignal.Accounts) do
      {:ok, user} ->
        put_session(conn, :user_id, user.id)
        |> configure_session(renew: true)
        |> success("You have been logged in", user_path(conn, :show, user))
      {:error, message} ->
        error(conn, message, session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    configure_session(conn, drop: true)
    |> success("You have been logged out", page_path(conn, :index))
  end
end
