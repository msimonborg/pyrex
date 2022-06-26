defmodule PYREx.Sources do
  @moduledoc """
  The sources for the PYREx database.
  Sources are fetched from a remote git repository and require an internet
  connection to return results.
  """

  @doc """
  Get a list of sources from the remote repo.
  """
  def get!(url) do
    response_body = Req.get!(url).body
    YamlElixir.read_from_string!(response_body)
  end

  @doc """
  The url paths for shapefile data.
  """
  def shapefiles! do
    get!("https://raw.githubusercontent.com/phoneyourrep/sources/master/shapefiles.yml")
  end

  @doc """
  The url paths for shapefile data.
  """
  def us_legislators! do
    url =
      "https://raw.githubusercontent.com/unitedstates/" <>
        "congress-legislators/main/legislators-current.yaml"

    get!(url)
  end
end
