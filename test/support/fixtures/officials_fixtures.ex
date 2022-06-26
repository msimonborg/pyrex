defmodule PYREx.OfficialsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `PYREx.Officials` context.
  """

  @doc """
  Generate a person.
  """
  def person_fixture(attrs \\ %{}) do
    {:ok, person} =
      attrs
      |> Enum.into(%{
        id: "some id",
        birthday: ~D[2022-06-25],
        first: "some first",
        gender: "some gender",
        last: "some last",
        official_full: "some official_full"
      })
      |> PYREx.Officials.create_person()

    person
  end

  @doc """
  Generate a id.
  """
  def id_fixture(attrs \\ %{}) do
    {:ok, id} =
      attrs
      |> Enum.into(%{
        type: "some type",
        value: "some value"
      })
      |> PYREx.Officials.create_id()

    id
  end

  @doc """
  Generate a term.
  """
  def term_fixture(attrs \\ %{}) do
    {:ok, term} =
      attrs
      |> Enum.into(%{
        bioguide: "some bioguide",
        address: "some address",
        class: 42,
        contact_form: "some contact_form",
        district: "some district",
        end: ~D[2022-06-25],
        geoid: "some geoid",
        office: "some office",
        party: "some party",
        phone: "some phone",
        rss_url: "some rss_url",
        start: ~D[2022-06-25],
        state: "some state",
        statefp: "some statefp",
        state_rank: "some state_rank",
        type: "some type",
        url: "some url",
        current: true
      })
      |> PYREx.Officials.create_term()

    term
  end

  @doc """
  An example of a person with associations params.
  """
  def person_attrs_with_associations do
    %{
      "birthday" => "1952-11-09",
      "first" => "Sherrod",
      "gender" => "M",
      "id" => "B000944",
      "ids" => [
        %{"type" => "ballotpedia", "value" => "Sherrod Brown"},
        %{"type" => "bioguide", "value" => "B000944"},
        %{"type" => "cspan", "value" => "5051"},
        %{"type" => "fec", "value" => "H2OH13033S6OH00163"},
        %{"type" => "google_entity_id", "value" => "kg:/m/034s80"},
        %{"type" => "govtrack", "value" => "400050"},
        %{"type" => "house_history", "value" => "9996"},
        %{"type" => "icpsr", "value" => "29389"},
        %{"type" => "lis", "value" => "S307"},
        %{"type" => "maplight", "value" => "168"},
        %{"type" => "opensecrets", "value" => "N00003535"},
        %{"type" => "thomas", "value" => "00136"},
        %{"type" => "votesmart", "value" => "27018"},
        %{"type" => "wikidata", "value" => "Q381880"},
        %{"type" => "wikipedia", "value" => "Sherrod Brown"}
      ],
      "last" => "Brown",
      "official_full" => "Sherrod Brown",
      "terms" => [
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "1995-01-03",
          "party" => "Democrat",
          "start" => "1993-01-05",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "1997-01-03",
          "party" => "Democrat",
          "start" => "1995-01-04",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "1999-01-03",
          "party" => "Democrat",
          "start" => "1997-01-07",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "2001-01-03",
          "party" => "Democrat",
          "start" => "1999-01-06",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "2003-01-03",
          "party" => "Democrat",
          "start" => "2001-01-03",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "2005-01-03",
          "party" => "Democrat",
          "start" => "2003-01-07",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep",
          "url" => "http://www.house.gov/sherrodbrown"
        },
        %{
          "bioguide" => "B000944",
          "current" => false,
          "district" => "13",
          "end" => "2007-01-03",
          "party" => "Democrat",
          "start" => "2005-01-04",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "rep",
          "url" => "http://www.house.gov/sherrodbrown"
        },
        %{
          "bioguide" => "B000944",
          "address" => "713 HART SENATE OFFICE BUILDING WASHINGTON DC 20510",
          "class" => 1,
          "contact_form" => "http://www.brown.senate.gov/contact/",
          "current" => false,
          "district" => "at-large",
          "end" => "2013-01-03",
          "fax" => "202-228-6321",
          "office" => "713 Hart Senate Office Building",
          "party" => "Democrat",
          "phone" => "202-224-2315",
          "start" => "2007-01-04",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "type" => "sen",
          "url" => "http://brown.senate.gov/"
        },
        %{
          "bioguide" => "B000944",
          "address" => "713 Hart Senate Office Building Washington DC 20510",
          "class" => 1,
          "contact_form" => "http://www.brown.senate.gov/contact/",
          "current" => false,
          "district" => "at-large",
          "end" => "2019-01-03",
          "fax" => "202-228-6321",
          "office" => "713 Hart Senate Office Building",
          "party" => "Democrat",
          "phone" => "202-224-2315",
          "rss_url" => "http://www.brown.senate.gov/rss/feeds/?type=all&amp;",
          "start" => "2013-01-03",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "state_rank" => "senior",
          "type" => "sen",
          "url" => "https://www.brown.senate.gov"
        },
        %{
          "bioguide" => "B000944",
          "address" => "503 Hart Senate Office Building Washington DC 20510",
          "class" => 1,
          "contact_form" => "https://www.brown.senate.gov/contact/",
          "current" => true,
          "district" => "at-large",
          "end" => "2025-01-03",
          "office" => "503 Hart Senate Office Building",
          "party" => "Democrat",
          "phone" => "202-224-2315",
          "rss_url" => "http://www.brown.senate.gov/rss/feeds/?type=all&amp;",
          "start" => "2019-01-03",
          "state" => "OH",
          "statefp" => "39",
          "geoid" => "39",
          "state_rank" => "senior",
          "type" => "sen",
          "url" => "https://www.brown.senate.gov"
        }
      ]
    }
  end
end
