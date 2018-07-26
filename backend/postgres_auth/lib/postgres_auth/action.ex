defmodule PostgresAuth.Action do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  alias PostgresAuth.{Action, Repo}

  schema "actions" do
    field(:name, :string)
    field(:entity_type, :string)
    field(:entity_id, :string)
    field(:data, :map)

    timestamps()
  end

  def changeset(record, params \\ :empty) do
    record
    |> cast(params, [:name, :entity_type, :entity_id, :data])
    |> validate_required([:name, :entity_type, :entity_id])
  end

  def add(name, type, id) do
    %Action{}
    |> Action.changeset(%{name: name, entity_type: type, entity_id: id})
    |> Repo.insert!()
  end

  def summary() do
    query = from(t in Action, select: t.name)

    Repo.all(query)
  end
end
