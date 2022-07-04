defmodule Pyrex.Geometry do
  @moduledoc """
  A module for converting user input into geometry data types.
  """

  @type latlon :: :lat | :lon
  @type coordinate :: String.t() | float()

  @spec point(Geo.Point.t() | %{latlon => String.t() | float()}, integer) :: Geo.Point.t()
  def point(location, srid)

  def point(location, srid) when is_struct(location, Geo.Point) do
    %{location | srid: srid}
  end

  def point(location, srid) do
    location
    |> normalize_location()
    |> do_point(srid)
  end

  defp do_point(%{lat: lat, lon: lon}, srid) do
    %Geo.Point{coordinates: {lat, lon}, srid: srid}
  end

  defp normalize_location(%{lat: lat, lon: lon} = location)
       when is_binary(lat) and is_binary(lon) do
    Map.new(location, fn {k, v} -> {k, String.to_float(v)} end)
  end

  defp normalize_location(%{lat: lat, lon: lon} = location)
       when is_number(lat) and is_number(lon) do
    location
  end
end
