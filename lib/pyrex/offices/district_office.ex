defmodule PYREx.Offices.DistrictOffice do
  @moduledoc """
  A schema for the district offices of elected officials.
  """

  use PYREx.Schema

  import Ecto.Changeset

  schema "district_offices" do
    field :address, :string
    field :building, :string
    field :city, :string
    field :fax, :string
    field :geom, Geo.PostGIS.Geometry
    field :hours, :string
    field :lat, :float
    field :lon, :float
    field :phone, :string
    field :state, :string
    field :statefp, :string
    field :suite, :string
    field :zip, :string
    field :person_id, :string

    timestamps()
  end

  @cast_fields [
    :id,
    :address,
    :suite,
    :city,
    :state,
    :statefp,
    :zip,
    :lat,
    :lon,
    :person_id,
    :phone,
    :fax,
    :building,
    :hours
  ]

  @required_fields [
    :id,
    :address,
    :city,
    :state,
    :statefp,
    :zip,
    :lat,
    :lon,
    :phone
  ]

  @doc false
  def changeset(district_office, attrs) do
    district_office
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
    |> project_point()
  end

  defp project_point(changeset) do
    lat = Map.get(changeset.changes, :lat, changeset.data.lat)
    lon = Map.get(changeset.changes, :lon, changeset.data.lon)

    if lat && lon do
      coordinates = %{lat: lat, lon: lon}
      change(changeset, geom: PYREx.Geometry.point(coordinates, PYREx.Shapefile.srid()))
    else
      changeset
    end
  end
end
