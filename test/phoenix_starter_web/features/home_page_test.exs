defmodule PhoenixStarter.Features.HomePageTest do
  use PhoenixStarter.FeatureCase, async: true

  import Wallaby.Query

  test "users can create todos", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("p", text: "Hello World!"))
  end
end
