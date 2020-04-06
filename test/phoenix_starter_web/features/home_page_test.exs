defmodule PhoenixStarter.Features.HomePageTest do
  use PhoenixStarter.FeatureCase, async: true

  import Wallaby.Query

  test "users can create todos", %{session: session} do
    session
    |> visit("/")
    |> find(css("section.phx-hero"))
    |> assert_has(css("h1", text: "Welcome to Phoenix!"))
  end
end