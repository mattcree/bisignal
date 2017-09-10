defmodule BisignalWeb.PageController do
  use BisignalWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def help(conn, _params) do
    render conn, "help.html"
  end
end
