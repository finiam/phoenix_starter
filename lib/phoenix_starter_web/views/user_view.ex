defmodule PhoenixStarterWeb.UserView do
  use PhoenixStarterWeb, :view
  alias PhoenixStarterWeb.UserView

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
