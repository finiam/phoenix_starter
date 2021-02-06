defmodule PhoenixStarterWeb.UserController do
  use PhoenixStarterWeb, :controller

  alias PhoenixStarter.Accounts
  alias PhoenixStarter.Accounts.User
  alias PhoenixStarterWeb.Auth

  action_fallback PhoenixStarterWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> Auth.Plug.sign_in(user)
      |> render("show.json", user: user)
    end
  end

  def show(conn, _) do
    current_user = conn.assigns.current_user

    render(conn, "show.json", user: current_user)
  end

  def update(conn, %{"user" => user_params}) do
    current_user = conn.assigns.current_user

    with {:ok, %User{} = user} <-
           Accounts.update_user(current_user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, _) do
    current_user = conn.assigns.current_user

    with {:ok, %User{}} <- Accounts.delete_user(current_user) do
      Auth.Plug.sign_out(conn)
      |> send_resp(:ok, "")
    end
  end
end
