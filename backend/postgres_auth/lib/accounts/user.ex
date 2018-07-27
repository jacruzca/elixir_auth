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

    field(:password, :string, virtual: true)
    field(:password_confirmation, :string, virtual: true)

    timestamps()
  end

  @required_fields [:first_name, :last_name, :email, :password, :password_confirmation]

  def changeset(user, attrs \\ %{}) do
    user
    |> cast(attrs, @required_fields)
    |> validate_confirmation(:password, message: "does not match password!")
    |> encrypt_password()
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
  end

  def serialize(%User{
        first_name: first_name,
        last_name: last_name,
        email: email,
        birth_date: birth_date
      }) do
    %{first_name: first_name, last_name: last_name, email: email, birth_date: birth_date}
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

  defp encrypt_password(changeset) do
    with password when not is_nil(password) <- get_change(changeset, :password) do
      put_change(changeset, :encrypted_password, Comeonin.Bcrypt.hashpwsalt(password))
    else
      _ -> changeset
    end
  end
end
