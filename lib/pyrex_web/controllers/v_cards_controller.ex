defmodule PyrexWeb.VCardsController do
  @moduledoc false

  use PyrexWeb, :controller

  alias Pyrex.{Offices, Officials, VCard}

  def download(conn, %{"office_id" => office_id}) do
    district_office = Offices.get_district_office!(office_id)
    person = Officials.get_person!(district_office.person_id, preload: [:current_term])
    vcf = VCard.encode(person, district_office)
    send_download(conn, {:binary, vcf}, filename: filename(person, district_office))
  end

  defp filename(person, district_office) do
    snake_cased_name = snakecase(person.official_full)
    snake_cased_city = snakecase(district_office.city)
    "#{snake_cased_name}_#{snake_cased_city}.vcf"
  end

  defp snakecase(string) do
    string |> String.replace(" ", "_") |> String.downcase()
  end
end
