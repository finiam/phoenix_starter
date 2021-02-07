defmodule PhoenixStarter.Accounts do
  import Ecto.Query, warn: false
  alias PhoenixStarter.Repo

  alias PhoenixStarter.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user(attrs) when is_list(attrs) do
    Repo.get_by(User, attrs)
  end

  def get_user(id), do: Repo.get(User, id)

  def authenticate_user(email, password) do
    get_user(email: email)
    |> authenticate_resource(password)
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end

  defp authenticate_resource(nil, _password) do
    Argon2.no_user_verify()
    {:error, :invalid_credentials}
  end

  defp authenticate_resource(resource, password) do
    if Argon2.verify_pass(password, resource.encrypted_password) do
      {:ok, resource}
    else
      {:error, :invalid_credentials}
    end
  end
end
