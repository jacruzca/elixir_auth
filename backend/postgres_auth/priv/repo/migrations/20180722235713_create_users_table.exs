defmodule PostgresAuth.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:first_name, :string)
      add(:last_name, :string)
      add(:email, :string)
      add(:encrypted_password, :string)
      add(:birth_date, :utc_datetime)

      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
