defmodule Pyrex.VCard do
  @moduledoc """
  Generates a .vcf formatted string for legislator office contacts.
  """

  alias Pyrex.{Offices.DistrictOffice, Officials, Officials.Person, Officials.Term}

  @type person :: Person.t()
  @type office :: DistrictOffice.t()
  @type person_term :: Term.t()
  @type v_card :: binary

  @spec encode(person, office) :: v_card
  def encode(%Person{} = person, %DistrictOffice{} = district_office) do
    ~s"""
    BEGIN:VCARD
    VERSION:3.0
    KIND:location
    FN:#{person.official_full}
    N:#{person.last};#{person.first}
    GENDER:#{person.gender}
    BDAY:#{person.birthday |> to_string() |> String.replace("-", "")}
    ORG:#{person.official_full} #{district_office.city} Office
    SOURCE:https://phoneyourrep.org/v-cards/#{district_office.id}
    PHOTO:#{Officials.person_photo_url(person)}
    ADR;TYPE=work:#{district_office.address};#{district_office.city};#{district_office.state};#{district_office.zip}
    TEL;VALUE=uri;PREF=1;TYPE=voice:tel:+1-#{district_office.phone}
    GEO:"geo:#{district_office.lat},#{district_office.lon}"
    ROLE:#{if person.current_term.type == "sen", do: "U.S. Senator", else: "U.S. Representative"}
    END:VCARD
    """
  end
end
