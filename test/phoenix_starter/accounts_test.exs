defmodule PhoenixStarter.AccountsTest do
  use PhoenixStarter.DataCase

  alias PhoenixStarter.Accounts

  describe "users" do
    alias PhoenixStarter.Accounts.User

    @valid_attrs %{
      email: "email@mail.com",
      password: "some password",
      name: "some name"
    }
    @update_attrs %{
      email: "updated@mail.com",
      password: "some updated password",
      name: "some updated name"
    }
    @invalid_attrs %{email: nil, password: nil, name: nil}

    def create_user(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = create_user()

      assert Accounts.list_users() |> Enum.at(0) |> Map.get(:email) ==
               user.email
    end

    test "get_user/1 returns the user with given email" do
      user = create_user()

      assert Accounts.get_user(email: user.email).email == user.email
    end

    test "get_user!/1 returns the user with given id" do
      user = create_user()

      assert Accounts.get_user(user.id).email == user.email
    end

    test "authenticate_user/2 authenticates users with correct password" do
      user = create_user()

      assert {:ok, %User{} = authenticated_user} =
               Accounts.authenticate_user(user.email, @valid_attrs.password)

      assert authenticated_user.email == user.email
    end

    test "authenticate_user/2 does not authenticates users with correct password" do
      user = create_user()

      assert {:error, :invalid_credentials} =
               Accounts.authenticate_user(user.email, "bad password")
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "email@mail.com"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = create_user()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "updated@mail.com"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = create_user()

      assert {:error, %Ecto.Changeset{}} =
               Accounts.update_user(user, @invalid_attrs)

      assert user.email == Accounts.get_user(user.id).email
    end

    test "delete_user/1 deletes the user" do
      user = create_user()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert Accounts.get_user(user.id) == nil
    end

    test "change_user/1 returns a user changeset" do
      user = create_user()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end
end
