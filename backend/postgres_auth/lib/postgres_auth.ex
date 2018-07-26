defmodule PostgresAuth do
  alias PostgresAuth.Action

  def add(name, type, id) do
    Action.add(name, type, id)
  end

  def summary() do
    Action.summary()
  end
end
