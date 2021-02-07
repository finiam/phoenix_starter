defmodule PhoenixStarterWeb.SessionControllerTest do
  use PhoenixStarterWeb.ConnCase

  alias PhoenixStarter.Accounts

  @user_attrs %{
    email: "some email",
    password: "some password",
    name: "some name"
  }
  @login_attrs %{
    email: "some email",
    password: "some password"
  }

  def create_user do
    {:ok, user} = Accounts.create_user(@user_attrs)
    user
  end

  describe "login user" do
    test "renders user when data is valid", %{conn: conn} do
      create_user()

      conn =
        post(conn, Routes.session_path(conn, :create), session: @login_attrs)

      assert %{
               "id" => _id,
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "sets the token in the session", %{conn: conn} do
      create_user()

      conn =
        post(conn, Routes.session_path(conn, :create), session: @login_attrs)

      assert %{"guardian_default_token" => _} = get_session(conn)
    end

    test "returns not found status if password is wrong", %{conn: conn} do
      conn =
        post(conn, Routes.session_path(conn, :create),
          session: %{email: "some email", password: "bad password"}
        )

      assert conn.status == 404
    end

    test "returns not found status if user does not exist", %{conn: conn} do
      conn =
        post(conn, Routes.session_path(conn, :create),
          session: %{email: "some email", password: "bad password"}
        )

      assert response(conn, 404)
    end
  end

  describe "logout user" do
    @tag :authenticated
    test "logs out the user", %{conn: conn} do
      conn = delete(conn, Routes.session_path(conn, :delete))

      assert get_session(conn) == %{}
      assert response(conn, 200)
    end

    test "returns not found status if not logged in", %{conn: conn} do
      conn = delete(conn, Routes.session_path(conn, :delete))

      assert response(conn, 404)
    end
  end
end
