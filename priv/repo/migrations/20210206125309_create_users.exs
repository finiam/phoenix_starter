defmodule PhoenixStarter.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :encrypted_password, :binary

      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
