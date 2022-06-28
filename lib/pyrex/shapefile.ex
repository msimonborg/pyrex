defmodule PYREx.Shapefile do
  @moduledoc """
  Read shapefile data.
  """

  # credo:disable-for-this-file

  def shp(shapefile) do
    File.stream!(shapefile, [], 2048)
    |> Exshape.Shp.read()
  end

  def dbf(shapefile) do
    File.stream!(shapefile, [], 2048)
    |> Exshape.Dbf.read()
  end

  @doc """
  Downloads the given shapefile from the U.S. Census Bureau and maps the data
  for database insertion. The file is not saved to the file system.
  """
  def map_download(filepath, base_url, opts \\ []) do
    tmp_dir = System.tmp_dir!()
    working_dir = Path.join([tmp_dir, random_string()])
    File.mkdir!(working_dir)

    shapefile = Path.join([tmp_dir, filepath])
    url = Path.join([base_url, filepath])
    opts = Keyword.merge(opts, raw: true, output: shapefile)
    Req.get!(url, opts)

    shapes =
      shapefile
      |> from_zip(working_dir: working_dir)
      |> map_shapes()

    File.rm!(shapefile)
    File.rm_rf!(working_dir)

    shapes
  end

  defp random_string do
    :crypto.strong_rand_bytes(32) |> Base.url_encode64() |> binary_part(0, 32)
  end

  @doc """
  Decodes data from a Zip archived shapefile in the current working directory.
  """
  def from_zip(shapefile, opts \\ []) do
    [{_, _, shapes}] = Exshape.from_zip(shapefile, opts)
    shapes
  end

  @doc """
  Parses unzipped shapefile data into maps.
  """
  def map_shapes(shapes) do
    [{_, dbf_header}] = Enum.take(shapes, 1)

    headers =
      dbf_header.columns
      |> Stream.map(fn column -> column.name end)
      |> Enum.with_index()

    {maps, _} =
      shapes
      |> Stream.drop(1)
      |> Enum.map_reduce(headers, fn {shp, dbf}, headers ->
        result =
          Enum.reduce(headers, %{geom: exshape_to_geo(shp)}, fn {attr, index}, map ->
            key =
              attr
              |> String.downcase()
              |> String.to_atom()

            val =
              case is_binary(x = Enum.at(dbf, index)) do
                true -> String.trim(x)
                false -> x
              end

            Map.put(map, key, val)
          end)

        {result, headers}
      end)

    maps
  end

  @doc """
  Transforms an `Exshape.Shp.Polygon.t()` to a `Geo.Polygon.t()`.
  ## Examples
      iex> PYREx.Shapefile.exshape_to_geo(%Exshape.Shp.Polygon{points: [[[
      ...>   %Exshape.Shp.Point{x: -96.639704, y: 42.737071},
      ...>   %Exshape.Shp.Point{x: -96.635886, y: 42.741002},
      ...>   %Exshape.Shp.Point{x: -96.632314, y: 42.745641}
      ...> ]]]})
      %Geo.MultiPolygon{coordinates: [[[
        {42.737071, -96.639704},
        {42.741002, -96.635886},
        {42.745641, -96.632314}
      ]]], srid: 4269}
  """
  def exshape_to_geo(%Exshape.Shp.Polygon{points: polygons}) do
    coordinates =
      Enum.map(polygons, fn polygon ->
        Enum.map(polygon, fn points ->
          Enum.map(points, fn %{x: lon, y: lat} ->
            {lat, lon}
          end)
        end)
      end)

    %Geo.MultiPolygon{coordinates: coordinates, srid: srid()}
  end

  @doc """
  The SRID projection used by the application. Returns the integer value `4269`.
  ## Examples
      iex> PYREx.Shapefile.srid()
      4269
  """
  def srid, do: 4269
end
