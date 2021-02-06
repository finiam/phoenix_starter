defmodule PhoenixStarterWeb.UserControllerTest do
  use PhoenixStarterWeb.ConnCase

  alias PhoenixStarter.Accounts
  alias PhoenixStarter.Accounts.User

  @create_attrs %{
    email: "some email",
    password: "some password",
    name: "some name"
  }
  @update_attrs %{
    email: "some updated email",
    password: "some updated password",
    name: "some updated name"
  }
  @invalid_attrs %{email: nil, password: nil, name: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      assert %{
               "id" => _id,
               "email" => "some email",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "creates user when data is valid", %{conn: conn} do
      post(conn, Routes.user_path(conn, :create), user: @create_attrs)

      user = Accounts.list_users() |> List.last()

      assert %User{
               id: _id,
               email: "some email",
               name: "some name"
             } = user
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.user_path(conn, :create), user: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    @tag :authenticated
    test "renders the current user when data is valid", %{conn: conn} do
      conn = put(conn, Routes.user_path(conn, :update), user: @update_attrs)

      assert %{
               "id" => _id,
               "email" => "some updated email",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    @tag :authenticated
    test "updates the current user when data is valid", %{conn: conn} do
      put(conn, Routes.user_path(conn, :update), user: @update_attrs)

      updated_user = Accounts.list_users() |> List.last()

      assert %User{
               id: _id,
               email: "some updated email",
               name: "some updated name"
             } = updated_user
    end

    @tag :authenticated
    test "changes the password when data is valid", %{conn: conn} do
      put(conn, Routes.user_path(conn, :update), user: @update_attrs)

      assert {:error, :invalid_credentials} =
               Accounts.authenticate_user(
                 @update_attrs.email,
                 @create_attrs.password
               )

      assert {:ok, %User{} = _authenticated_user} =
               Accounts.authenticate_user(
                 @update_attrs.email,
                 @update_attrs.password
               )
    end

    @tag :authenticated
    test "renders errors when data is invalid", %{conn: conn} do
      conn = put(conn, Routes.user_path(conn, :update), user: @invalid_attrs)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    @tag :authenticated
    test "deletes current user", %{conn: conn} do
      conn = delete(conn, Routes.user_path(conn, :delete))

      assert response(conn, 200)
      assert Accounts.list_users() == []

      assert get(conn, Routes.user_path(conn, :show)).status == 404
    end
  end
end
