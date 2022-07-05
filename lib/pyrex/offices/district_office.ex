defmodule Pyrex.Offices.DistrictOffice do
  @moduledoc """
  A schema for the district offices of elected officials.
  """

  use Pyrex.Schema

  import Ecto.Changeset

  alias Pyrex.Repo

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
    :phone
  ]

  @type t :: %__MODULE__{
          address: String.t(),
          building: String.t(),
          city: String.t(),
          fax: String.t(),
          geom: Geo.Point.t(),
          hours: String.t(),
          lat: float,
          lon: float,
          phone: String.t(),
          state: String.t(),
          statefp: String.t(),
          suite: String.t(),
          zip: String.t(),
          person_id: String.t(),
          updated_at: NaiveDateTime.t(),
          inserted_at: NaiveDateTime.t()
        }

  @doc false
  def changeset(district_office, attrs) do
    district_office
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:id, name: "district_offices_pkey")
    |> unsafe_validate_unique([:id], Repo)
    |> project_point()
  end

  defp project_point(changeset) do
    lat = Map.get(changeset.changes, :lat, changeset.data.lat)
    lon = Map.get(changeset.changes, :lon, changeset.data.lon)

    point =
      if lat && lon do
        Pyrex.Geometry.point(%{lat: lat, lon: lon}, Pyrex.Shapefile.srid())
      else
        Pyrex.Geometry.point(%{lat: 0.0, lon: 0.0}, Pyrex.Shapefile.srid())
      end

    change(changeset, geom: point)
  end
end
