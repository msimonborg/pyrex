defmodule Pyrex.Geographies.Shape do
  @moduledoc """
  The geospatial database record that defines the geometric
  shape of a Jurisdiction with the corresponding `pyrgeoid`.
  """

  use Pyrex.Schema

  import Ecto.Changeset

  alias Pyrex.Repo

  schema "shapes" do
    field :geom, Geo.PostGIS.Geometry
    field :mtfcc, :string
    field :geoid, :string

    belongs_to :jurisdiction,
               Pyrex.Geographies.Jurisdiction,
               references: :pyrgeoid,
               foreign_key: :pyrgeoid

    timestamps()
  end

  @doc false
  def changeset(shape, attrs) do
    shape
    |> cast(attrs, [:geoid, :geom, :mtfcc])
    |> validate_required([:geom, :geoid, :mtfcc])
    |> generate_pyrgeoid
    |> generate_id()
    |> validate_required([:id, :pyrgeoid])
    |> unique_constraint(:id, name: "shapes_pkey")
    |> unsafe_validate_unique([:id], Repo)
  end

  @doc false
  def generate_pyrgeoid(%Ecto.Changeset{} = changeset) do
    geoid = Map.get(changeset.changes, :geoid, changeset.data.geoid)
    mtfcc = Map.get(changeset.changes, :mtfcc, changeset.data.mtfcc)
    change(changeset, pyrgeoid: "#{mtfcc}#{geoid}")
  end

  @doc false
  def generate_id(%Ecto.Changeset{} = changeset) do
    pyrgeoid = Map.get(changeset.changes, :pyrgeoid, changeset.data.pyrgeoid)
    id = "pyr-shape/country:us/pyrgeoid:#{pyrgeoid}"
    change(changeset, id: id)
  end
end
