defmodule PYREx.Officials.ID do
  @moduledoc """
  IDs of different types for elected officials.
  """
  use PYREx.Schema

  import Ecto.Changeset

  alias PYREx.Repo

  schema "ids" do
    field :type, :string
    field :value, :string
    field :person_id, :string

    timestamps()
  end

  @doc false
  def changeset(id, attrs) do
    id
    |> cast(attrs, [:type, :value])
    |> validate_required([:type, :value])
    |> generate_id()
    |> validate_required([:id])
    |> unique_constraint(:id, name: "ids_pkey")
    |> unsafe_validate_unique([:id], Repo)
  end

  defp generate_id(changeset) do
    type = Map.get(changeset.changes, :type, changeset.data.type)
    value = Map.get(changeset.changes, :value, changeset.data.value)

    change(changeset, id: "#{type}:#{value}")
  end
end
