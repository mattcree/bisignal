defmodule BisignalWeb.PageController do
  use BisignalWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
