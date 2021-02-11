defmodule PhoenixStarterWeb.SessionView do
  use PhoenixStarterWeb, :view
  alias PhoenixStarterWeb.UserView

  def render(template, assigns) do
    UserView.render(template, assigns)
  end
end
