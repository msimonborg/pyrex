defmodule PyrexWeb.VCardsController do
  @moduledoc false

  use PyrexWeb, :controller

  alias Pyrex.{Offices, Officials, VCard}

  def district_offices(conn, %{"office_id" => office_id}) do
    district_office = Offices.get_district_office!(office_id)
    person = Officials.get_person!(district_office.person_id, preload: [:current_term])
    vcf = VCard.encode(person, district_office)
    do_send_download(conn, vcf, person.official_full, district_office.city)
  end

  def current_terms(conn, %{"person_id" => person_id}) do
    person = Officials.get_person!(person_id, preload: [:current_term])
    vcf = VCard.encode(person)
    do_send_download(conn, vcf, person.official_full, "D.C.")
  end

  defp do_send_download(conn, vcf, name, city) do
    send_download(conn, {:binary, vcf}, filename: filename(name, city))
  end

  defp filename(name, city) do
    snake_cased_name = snakecase(name)
    snake_cased_city = snakecase(city)
    "#{snake_cased_name}_#{snake_cased_city}.vcf"
  end

  defp snakecase(string) do
    string |> String.replace(" ", "_") |> String.replace(".", "") |> String.downcase()
  end
end
