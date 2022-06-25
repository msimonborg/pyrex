defmodule PYREx.Geographies do
  @moduledoc """
  The Geographies context.
  """

  import Ecto.Query, warn: false
  import Geo.PostGIS

  alias PYREx.{Geographies.Shape, Repo}

  @doc """
  Returns the list of shapes.
  ## Examples
      iex> list_shapes()
      [%Shape{}, ...]
  """
  def list_shapes do
    Repo.all(Shape)
  end

  @doc """
  Gets a single shape.
  Raises `Ecto.NoResultsError` if the Shape does not exist.
  ## Examples
      iex> get_shape!(123)
      %Shape{}
      iex> get_shape!(456)
      ** (Ecto.NoResultsError)
  """
  def get_shape!(id), do: Repo.get!(Shape, id)

  @doc """
  Creates a shape.
  ## Examples
      iex> create_shape(%{field: value})
      {:ok, %Shape{}}
      iex> create_shape(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_shape(attrs \\ %{}) do
    %Shape{}
    |> Shape.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a shape.
  ## Examples
      iex> update_shape(shape, %{field: new_value})
      {:ok, %Shape{}}
      iex> update_shape(shape, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_shape(%Shape{} = shape, attrs) do
    shape
    |> Shape.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Shape.
  ## Examples
      iex> delete_shape(shape)
      {:ok, %Shape{}}
      iex> delete_shape(shape)
      {:error, %Ecto.Changeset{}}
  """
  def delete_shape(%Shape{} = shape) do
    Repo.delete(shape)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking shape changes.
  ## Examples
      iex> change_shape(shape)
      %Ecto.Changeset{source: %Shape{}}
  """
  def change_shape(%Shape{} = shape) do
    Shape.changeset(shape, %{})
  end

  @doc """
  Returns a list of shapes that intersect the given geometry.
  Input can be a tuple containing two strings or floats (lat and lon), a binary
  street address, or a Geo struct.
  """
  def intersecting_shapes(address) when is_binary(address) do
    case Geocodex.coordinates(address) do
      {:ok, %{x: x, y: y}} -> intersecting_shapes({y, x})
      :error -> []
    end
  end

  def intersecting_shapes({lat, lon}) when is_binary(lat) and is_binary(lon) do
    intersecting_shapes({String.to_float(lat), String.to_float(lon)})
  end

  def intersecting_shapes(coordinates = {lat, lon}) when is_number(lat) and is_number(lon) do
    %Geo.Point{coordinates: coordinates, srid: PYREx.Shapefile.srid()}
    |> intersecting_shapes()
  end

  def intersecting_shapes(geom) do
    query =
      from(shape in Shape,
        where: st_intersects(shape.geom, ^geom)
      )

    Repo.all(query)
  end

  alias PYREx.Geographies.Jurisdiction

  @doc """
  Returns the list of jurisdictions.
  ## Examples
      iex> list_jurisdictions()
      [%Jurisdiction{}, ...]
  """
  def list_jurisdictions do
    Repo.all(Jurisdiction)
  end

  @doc """
  Gets a single jurisdiction.
  Raises `Ecto.NoResultsError` if the Jurisdiction does not exist.
  ## Examples
      iex> get_jurisdiction!(123)
      %Jurisdiction{}
      iex> get_jurisdiction!(456)
      ** (Ecto.NoResultsError)
  """
  def get_jurisdiction!(id), do: Repo.get!(Jurisdiction, id)

  @doc """
  Creates a jurisdiction.
  ## Examples
      iex> create_jurisdiction(%{field: value})
      {:ok, %Jurisdiction{}}
      iex> create_jurisdiction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def create_jurisdiction(attrs \\ %{}) do
    %Jurisdiction{}
    |> Jurisdiction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a jurisdiction.
  ## Examples
      iex> update_jurisdiction(jurisdiction, %{field: new_value})
      {:ok, %Jurisdiction{}}
      iex> update_jurisdiction(jurisdiction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  def update_jurisdiction(%Jurisdiction{} = jurisdiction, attrs) do
    jurisdiction
    |> Jurisdiction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Jurisdiction.
  ## Examples
      iex> delete_jurisdiction(jurisdiction)
      {:ok, %Jurisdiction{}}
      iex> delete_jurisdiction(jurisdiction)
      {:error, %Ecto.Changeset{}}
  """
  def delete_jurisdiction(%Jurisdiction{} = jurisdiction) do
    Repo.delete(jurisdiction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking jurisdiction changes.
  ## Examples
      iex> change_jurisdiction(jurisdiction)
      %Ecto.Changeset{source: %Jurisdiction{}}
  """
  def change_jurisdiction(%Jurisdiction{} = jurisdiction) do
    Jurisdiction.changeset(jurisdiction, %{})
  end

  @doc """
  Returns a list of Jursidictions whose shapes intersect the given geometry.
  Input can be a tuple containing two strings or floats (lat and lon), a binary
  street address, or a Geo struct.
  ## Examples
      intersecting_jurisdictions({33.184123, -88.317135})
      #=> [%PYREx.Geographies.Jurisdiction{
            __meta__: #Ecto.Schema.Metadata<:loaded, "jurisdictions">,
            geoid: "01",
            id: "pyr-jurisdiction/type:us_state/country:us/pyrgeoid:G400001/statefp:01",
            inserted_at: ~N[2019-03-24 00:23:52],
            name: "Alabama",
            shape: #Ecto.Association.NotLoaded<association :shape is not loaded>,
            statefp: "01",
            mtfcc: G4000,
            pyrgeoid: G400001,
            type: "us_state",
            updated_at: ~N[2019-03-24 00:23:52]
          }, %PYREx.Geographies.Jurisdiction{...}, ...]
  """
  def intersecting_jurisdictions(address) when is_binary(address) do
    case Geocodex.coordinates(address) do
      {:ok, %{x: x, y: y}} -> intersecting_jurisdictions({y, x})
      :error -> []
    end
  end

  def intersecting_jurisdictions({lat, lon}) when is_binary(lat) and is_binary(lon) do
    intersecting_jurisdictions({String.to_float(lat), String.to_float(lon)})
  end

  def intersecting_jurisdictions(coordinates = {lat, lon})
      when is_number(lat) and is_number(lon) do
    %Geo.Point{coordinates: coordinates, srid: PYREx.Shapefile.srid()}
    |> intersecting_jurisdictions()
  end

  def intersecting_jurisdictions(geom) do
    query =
      from(j in Jurisdiction,
        join: s in assoc(j, :shape),
        where: st_intersects(s.geom, ^geom)
      )

    Repo.all(query)
  end
end
