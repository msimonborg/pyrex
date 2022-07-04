defmodule Pyrex.OfficesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Pyrex.Offices` context.
  """

  @doc """
  Generate a district_office.
  """
  def district_office_fixture(attrs \\ %{}) do
    {:ok, district_office} =
      attrs
      |> Enum.into(%{
        address: "some address",
        building: "some building",
        city: "some city",
        fax: "some fax",
        hours: "some hours",
        id: "some id",
        lat: 1.001,
        lon: -1.001,
        phone: "some phone",
        state: "some state",
        statefp: "some statefp",
        suite: "some suite",
        zip: "some zip"
      })
      |> Pyrex.Offices.create_district_office()

    district_office
  end
end
