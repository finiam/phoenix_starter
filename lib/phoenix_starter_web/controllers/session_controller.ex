defmodule PhoenixStarterWeb.SessionController do
  use PhoenixStarterWeb, :controller

  alias PhoenixStarter.Accounts
  alias PhoenixStarterWeb.Auth

  action_fallback PhoenixStarterWeb.FallbackController

  def create(conn, %{"session" => %{"email" => email, "password" => password}}) do
    case Accounts.authenticate_user(email, password) do
      {:ok, user} ->
        conn
        |> Auth.Plug.sign_in(user)
        |> render("show.json", user: user)

      _ ->
        conn
        |> send_resp(:not_found, "")
    end
  end

  def delete(conn, _) do
    Auth.Plug.sign_out(conn)
    |> send_resp(:ok, "")
  end
end
