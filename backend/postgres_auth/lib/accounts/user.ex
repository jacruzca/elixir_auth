defmodule PostgresAuth.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias PostgresAuth.Accounts.User
  alias PostgresAuth.Repo

  schema "users" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:encrypted_password, :string)
    field(:birth_date, :utc_datetime)
    timestamps()
  end

  @required_fields [:first_name, :last_name, :email, :encrypted_password]

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def list, do: Repo.all(User)

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get(User, id)
  end

  def get_by_email(email) do
    Repo.get_by(User, email: email)
  end
end
