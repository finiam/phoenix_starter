defmodule PhoenixStarterWeb.ExampleController do
  use PhoenixStarterWeb, :controller

  def index(conn, _params) do
    render(conn, "index.json")
  end
end
