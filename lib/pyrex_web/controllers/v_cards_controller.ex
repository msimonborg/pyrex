defmodule PyrexWeb.VCardsController do
  @moduledoc false

  use PyrexWeb, :controller

  alias Pyrex.{Offices, Officials, VCard}

  def district_offices(conn, %{"office_id" => office_id}) do
    district_office = Offices.get_district_office!(office_id)
    person = Officials.get_person!(district_office.person_id, preload: [:current_term])
    generate_and_send_download(conn, person, district_office, district_office.city)
  end

  def current_terms(conn, %{"person_id" => person_id}) do
    person = Officials.get_person!(person_id, preload: [:current_term])
    generate_and_send_download(conn, person, person.current_term, "D.C.")
  end

  defp generate_and_send_download(conn, person, office_data, city) do
    vcf = VCard.encode(person, office_data)
    filename = filename(person.official_full, city)
    send_download(conn, {:binary, vcf}, filename: filename)
  end

  defp filename(name, city) do
    snake_cased_name = snakecase(name)
    snake_cased_city = snakecase(city)
    "#{snake_cased_name}_#{snake_cased_city}.vcf"
  end

  defp snakecase(string) do
    string |> String.replace(" ", "_") |> String.downcase()
  end
end
