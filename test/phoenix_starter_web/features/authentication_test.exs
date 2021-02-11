defmodule PhoenixStarter.Features.HomePageTest do
  alias PhoenixStarter.Accounts

  use PhoenixStarter.FeatureCase, async: true

  test "redirects unauthenticated users to log in page", %{session: session} do
    session
    |> visit("/")
    |> assert_has(css("h1", text: "Login"))
  end

  test "allows authenticated users to access home page", %{session: session} do
    {:ok, user} =
      Accounts.create_user(%{
        name: "some name",
        email: "someemail@mail.com",
        password: "foobar"
      })

    session
    |> visit("/")
    |> sign_in(user.email)
    |> assert_has(css("p", text: "Hello #{user.email}"))
  end

  test "logs in a user", %{session: session} do
    {:ok, user} =
      Accounts.create_user(%{
        name: "user",
        email: "user@mail.com",
        password: "foobar"
      })

    session
    |> visit("/")
    |> fill_in(text_field("Email"), with: user.email)
    |> fill_in(text_field("Password"), with: "foobar")
    |> click(button("Submit"))
    |> assert_has(css("p", text: "Hello #{user.email}"))
  end

  test "does not log in a user with a bad password", %{session: session} do
    {:ok, user} =
      Accounts.create_user(%{
        name: "user",
        email: "user@mail.com",
        password: "foobar"
      })

    session
    |> visit("/")
    |> fill_in(text_field("Email"), with: user.email)
    |> fill_in(text_field("Password"), with: "bad password")
    |> click(button("Submit"))
    |> assert_has(css("h1", text: "Login"))
    |> assert_has(css("p", text: "Bad login/password"))
  end

  test "signs up in a user", %{session: session} do
    session
    |> visit("/sign_up")
    |> fill_in(text_field("Name"), with: "user")
    |> fill_in(text_field("Email"), with: "user@mail.com")
    |> fill_in(text_field("Password"), with: "foobar")
    |> click(button("Submit"))
    |> assert_has(css("p", text: "Hello user"))

    created_user = Accounts.list_users() |> List.last()

    assert %{name: "user", email: "user@mail.com"} = created_user
  end

  test "does not sign up in a user with errors", %{session: session} do
    session
    |> visit("/sign_up")
    |> fill_in(text_field("Name"), with: "user")
    |> fill_in(text_field("Email"), with: "user@mail.com")
    |> fill_in(text_field("Password"), with: "")
    |> click(button("Submit"))
    |> assert_has(css("p", text: "can't be blank"))

    assert Accounts.list_users() == []
  end

  test "logs out a user", %{session: session} do
    {:ok, user} =
      Accounts.create_user(%{
        name: "some name",
        email: "someemail@mail.com",
        password: "foobar"
      })

    session
    |> visit("/")
    |> sign_in(user.email)
    |> click(button("Logout"))
    |> assert_has(css("h1", text: "Login"))
  end
end
