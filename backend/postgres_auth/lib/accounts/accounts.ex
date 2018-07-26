defmodule PostgresAuth.Accounts do
  alias PostgresAuth.Accounts.User
  alias PostgresAuth.Accounts.Session
  alias PostgresAuth.Util.ChangesetUtil

  def list_users, do: User.list()

  def signup(attrs \\ %{}) do
    with {:ok, _} <- get_user_by_email(attrs),
         {:ok, user} <- create_user(attrs),
         {:ok, token} <- Session.create_session_token(user) do
      {:ok, Session.new_session(user, token)}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def verify_token(token) do
    Session.verify_session_token(token)
  end

  defp create_user(attrs) do
    case User.create(attrs) do
      {:ok, struct} -> {:ok, struct}
      {:error, changeset} -> {:error, {:database, ChangesetUtil.serialize_errors(changeset)}}
    end
  end

  def get_user_by_email(%{email: email}) do
    case User.get_by_email(email) do
      nil -> {:ok, email}
      _ -> {:error, :email_already_exists}
    end
  end

  def get_user_by_email(%{}) do
    {:error, :invalid_email}
  end
end
