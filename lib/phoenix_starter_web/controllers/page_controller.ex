defmodule PhoenixStarterWeb.PageController do
  use PhoenixStarterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
