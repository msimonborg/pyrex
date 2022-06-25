defmodule Geocodex do
  @moduledoc """
  Geocoding library for Elixir that's extendable to multiple service providers.
  Geocodex uses the U.S. Census Bureau geocoding service by default, but you can
  configure a different provider in your `config.exs`:
      config :geocodex, provider: MyApp.Provider
  You can use any custom provider module that implements the `Geocodex.Provider` behaviour.
  Built-in providers:
    * `Geocodex.Provider.USCB` (default)
  """

  @typedoc "An address to be geocoded"
  @type address :: String.t()

  @typedoc "A map containing x/y coordinates"
  @type coordinates :: %{x: float, y: float}

  @doc """
  Geocodes an address into x/y coordinates.
  ## Examples
      iex> Geocodex.coordinates("1600 Pennsylvania Ave NW, Washington, D.C., 20500")
      {:ok, %{x: -77.03535, y: 38.898754}}
  """
  @spec coordinates(address) :: {:ok, coordinates}
  def coordinates(address), do: provider().coordinates(address)

  @doc """
  The configured geocoding service provider. Returns the name of a module that implements
  the Geocodex.Provider behaviour.
  ## Examples
      iex> Geocodex.provider()
      Geocodex.Provider.USCB
  """
  @spec provider :: module
  def provider, do: Application.get_env(:geocodex, :provider, Geocodex.Providers.USCB)
end
