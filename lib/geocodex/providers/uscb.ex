defmodule Geocodex.Providers.USCB do
  @moduledoc """
  U.S. Census Bureau geocoding service.
  """

  use Geocodex.Provider

  @url "https://geocoding.geo.census.gov/geocoder/locations/onelineaddress"
  @headers [{"Accept", "application/json"}]
  @default_params [benchmark: "Public_AR_Current"]

  @doc false
  @impl Geocodex.Provider
  @spec coordinates(Geocodex.address()) ::
          {:ok, Geocodex.coordinates()} | {:error, :coordinates_not_found}
  def coordinates(address) do
    params = Keyword.merge(@default_params, address: address)
    body = Req.get!(@url, params: params, headers: @headers).body

    coordinates = get_in(body, ["result", "addressMatches", Access.at(0), "coordinates"])

    case coordinates do
      %{"x" => x, "y" => y} -> {:ok, %{lon: x, lat: y}}
      nil -> {:error, "address not found"}
    end
  end
end
