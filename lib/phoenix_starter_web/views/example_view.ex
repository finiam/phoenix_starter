defmodule PhoenixStarterWeb.ExampleView do
  use PhoenixStarterWeb, :view

  def render("index.json", _) do
    %{message: "example"}
  end
end
