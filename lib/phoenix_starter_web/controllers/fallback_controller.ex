defmodule PhoenixStarterWeb.FallbackController do
  use PhoenixStarterWeb, :controller

  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(PhoenixStarterWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(PhoenixStarterWeb.ErrorView)
    |> render(:"404")
  end
end
