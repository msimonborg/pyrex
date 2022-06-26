defmodule PYREx.OfficesTest do
  use PYREx.DataCase

  alias PYREx.Offices

  describe "district_offices" do
    alias PYREx.Offices.DistrictOffice

    import PYREx.OfficesFixtures

    @invalid_attrs %{
      address: nil,
      building: nil,
      city: nil,
      fax: nil,
      hours: nil,
      id: nil,
      lat: nil,
      lon: nil,
      phone: nil,
      state: nil,
      statefp: nil,
      suite: nil,
      zip: nil
    }

    test "list_district_offices/0 returns all district_offices" do
      district_office = district_office_fixture()
      assert Offices.list_district_offices() == [district_office]
    end

    test "get_district_office!/1 returns the district_office with given id" do
      district_office = district_office_fixture()
      assert Offices.get_district_office!(district_office.id) == district_office
    end

    test "create_district_office/1 with valid data creates a district_office" do
      valid_attrs = %{
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
      }

      assert {:ok, %DistrictOffice{} = district_office} =
               Offices.create_district_office(valid_attrs)

      assert district_office.address == "some address"
      assert district_office.building == "some building"
      assert district_office.city == "some city"
      assert district_office.fax == "some fax"
      assert district_office.hours == "some hours"
      assert district_office.id == "some id"
      assert district_office.lat == 1.001
      assert district_office.lon == -1.001
      assert district_office.phone == "some phone"
      assert district_office.state == "some state"
      assert district_office.statefp == "some statefp"
      assert district_office.suite == "some suite"
      assert district_office.zip == "some zip"
    end

    test "create_district_office/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Offices.create_district_office(@invalid_attrs)
    end

    test "update_district_office/2 with valid data updates the district_office" do
      district_office = district_office_fixture()

      update_attrs = %{
        address: "some updated address",
        building: "some updated building",
        city: "some updated city",
        fax: "some updated fax",
        hours: "some updated hours",
        id: "some updated id",
        lat: 1.002,
        lon: -1.002,
        phone: "some updated phone",
        state: "some updated state",
        statefp: "some updated statefp",
        suite: "some updated suite",
        zip: "some updated zip"
      }

      assert {:ok, %DistrictOffice{} = district_office} =
               Offices.update_district_office(district_office, update_attrs)

      assert district_office.address == "some updated address"
      assert district_office.building == "some updated building"
      assert district_office.city == "some updated city"
      assert district_office.fax == "some updated fax"
      assert district_office.hours == "some updated hours"
      assert district_office.id == "some updated id"
      assert district_office.lat == 1.002
      assert district_office.lon == -1.002
      assert district_office.phone == "some updated phone"
      assert district_office.state == "some updated state"
      assert district_office.statefp == "some updated statefp"
      assert district_office.suite == "some updated suite"
      assert district_office.zip == "some updated zip"
    end

    test "update_district_office/2 with invalid data returns error changeset" do
      district_office = district_office_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Offices.update_district_office(district_office, @invalid_attrs)

      assert district_office == Offices.get_district_office!(district_office.id)
    end

    test "delete_district_office/1 deletes the district_office" do
      district_office = district_office_fixture()
      assert {:ok, %DistrictOffice{}} = Offices.delete_district_office(district_office)
      assert_raise Ecto.NoResultsError, fn -> Offices.get_district_office!(district_office.id) end
    end

    test "change_district_office/1 returns a district_office changeset" do
      district_office = district_office_fixture()
      assert %Ecto.Changeset{} = Offices.change_district_office(district_office)
    end
  end
end
