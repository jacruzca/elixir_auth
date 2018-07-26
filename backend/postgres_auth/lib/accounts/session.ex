defmodule PostgresAuth.Accounts.Session do
  alias PostgresAuth.Accounts.User
  alias PostgresAuth.Accounts.Session
  alias PostgresAuth.Guardian

  @enforce_keys [:user, :token]
  defstruct user: nil, token: nil

  def new_session(user, token) do
    %Session{user: user, token: token}
  end

  def create_session_token(%User{} = user) do
    {:ok, token, _} = Guardian.encode_and_sign(user)
    {:ok, token}
  end

  def verify_session_token(token) do
    Guardian.decode_and_verify(token)
  end
end
