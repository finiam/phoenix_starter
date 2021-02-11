defmodule PhoenixStarter.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @fields [:email, :name, :password]
  @required_fields [:email, :name, :password]
  @email_regex ~r/^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/

  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :encrypted_password, :binary
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email, downcase: true)
    |> validate_format(:email, @email_regex)
    |> validate_length(:password, min: 6)
    |> encrypt_password()
  end

  defp encrypt_password(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} =
           changeset
       ) do
    change(changeset, encrypted_password: Argon2.hash_pwd_salt(password))
  end

  defp encrypt_password(changeset), do: changeset
end
