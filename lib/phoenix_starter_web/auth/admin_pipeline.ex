defmodule PhoenixStarterWeb.Auth.AdminPipeline do
  use Guardian.Plug.Pipeline, otp_app: :phoenix_starter

  plug PhoenixStarterWeb.Auth.Pipeline
  plug :admin

  def admin(conn, _opts) do
    case conn.assigns.current_user.role do
      "admin" -> conn
      _ -> conn |> send_resp(:not_found, "") |> halt()
    end
  end
end
