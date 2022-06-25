defmodule Geocodex.Provider do
  @moduledoc """
  A behaviour for geocoder service providers.

  You can implement the behaviour by using it in a module:

      defmodule MyApp.Provider do
        use Geocodex.Provider
      end

  A provider must implement the `coordinates` callback, returning
  `{:ok, coordinates}` or `{:error, reason}`.
  """

  @doc """
  Invoked to geocode an address into x/y coordinates
  """
  @callback coordinates(Geocodex.address()) :: {:ok, Geocodex.coordinates()} | {:error, term}

  @doc false
  defmacro __using__(opts) do
    quote location: :keep, bind_quoted: [opts: opts] do
      @behaviour Geocodex.Provider
    end
  end
end
