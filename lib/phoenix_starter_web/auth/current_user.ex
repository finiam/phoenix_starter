defmodule PhoenixStarterWeb.Auth.CurrentUser do
  alias PhoenixStarterWeb.Auth

  def init(opts), do: opts

  def call(conn, _opts) do
    conn
    |> Plug.Conn.assign(:current_user, Auth.Plug.current_resource(conn))
  end
end
