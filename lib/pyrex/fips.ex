defmodule PYREx.FIPS do
  @moduledoc """
  U.S. Federal Information Processing Standards (FIPS) data.
  """

  @state_codes %{
    "AL" => "01",
    "AK" => "02",
    "AZ" => "04",
    "AR" => "05",
    "AS" => "60",
    "CA" => "06",
    "CO" => "08",
    "CT" => "09",
    "DE" => "10",
    "DC" => "11",
    "FM" => "64",
    "FL" => "12",
    "GA" => "13",
    "GU" => "66",
    "HI" => "15",
    "ID" => "16",
    "IL" => "17",
    "IN" => "18",
    "IA" => "19",
    "KS" => "20",
    "KY" => "21",
    "LA" => "22",
    "ME" => "23",
    "MD" => "24",
    "MA" => "25",
    "MI" => "26",
    "MH" => "68",
    "MN" => "27",
    "MS" => "28",
    "MO" => "29",
    "MP" => "69",
    "MT" => "30",
    "NE" => "31",
    "NV" => "32",
    "NH" => "33",
    "NJ" => "34",
    "NM" => "35",
    "NY" => "36",
    "NC" => "37",
    "ND" => "38",
    "OH" => "39",
    "OK" => "40",
    "OR" => "41",
    "PA" => "42",
    "PW" => "70",
    "PR" => "72",
    "RI" => "44",
    "SC" => "45",
    "SD" => "46",
    "TN" => "47",
    "TX" => "48",
    "UM" => "74",
    "UT" => "49",
    "VT" => "50",
    "VA" => "51",
    "VI" => "78",
    "WA" => "53",
    "WV" => "54",
    "WI" => "55",
    "WY" => "56"
  }

  @doc """
  Returns the two digit FIPS code for the given state abbreviation.

  Returns nil if no code exists for the given argument.

  ## Examples

      iex> PYREx.FIPS.state_code("VT")
      "50"

      iex> PYREx.FIPS.state_code("CA")
      "06"

      iex> PYREx.FIPS.state_code("MP")
      "69"

      iex> PYREx.FIPS.state_code("XY")
      nil
  """
  def state_code(state_abbr) when is_binary(state_abbr), do: @state_codes[state_abbr]
end
