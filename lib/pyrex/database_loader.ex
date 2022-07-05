defmodule Pyrex.DatabaseLoader do
  # credo:disable-for-this-file
  require Logger
  alias Pyrex.{Repo, Shapefile, Sources}
  alias Pyrex.Geographies.{Shape, Jurisdiction}

  def us_legislators do
    reps = Sources.us_legislators!()

    Enum.each(reps, fn rep ->
      bioguide = get_in(rep, ["id", "bioguide"])

      rep
      |> Map.merge(rep["bio"])
      |> Map.merge(rep["name"])
      |> Map.put("ids", rep["id"])
      |> Map.put("id", bioguide)
      |> Map.update("ids", [], &normalize_ids/1)
      |> Map.update("terms", [], fn terms -> normalize_terms(terms, bioguide) end)
      |> Map.drop(["bio", "name"])
      |> Pyrex.Officials.create_or_update_person!()
    end)
  end

  defp normalize_ids(ids) do
    Enum.map(ids, fn {k, v} ->
      %{"type" => k, "value" => to_string(v)}
    end)
    |> Enum.reject(fn %{"value" => value} -> value == "" end)
  end

  defp normalize_terms(terms, bioguide) do
    Enum.map(terms, fn term ->
      current = if term == List.last(terms), do: true, else: false
      district = normalize_district(term["district"])
      statefp = Pyrex.FIPS.state_code!(term["state"])

      term
      |> Map.put_new("current", current)
      |> Map.put_new("bioguide", bioguide)
      |> Map.put_new("statefp", statefp)
      |> Map.put_new("geoid", statefp <> district)
      |> Map.update("district", "at-large", fn _ -> district end)
    end)
  end

  defp normalize_district(district) do
    district = to_string(district)
    if String.length(district) == 1, do: "0" <> district, else: district
  end

  def us_legislators_district_offices do
    entries = Sources.us_legislators_district_offices!()

    Enum.each(entries, fn entry ->
      bioguide = Map.fetch!(entry["id"], "bioguide")
      offices = Map.get(entry, "offices", [])

      Enum.each(offices, fn office ->
        office
        |> Map.put("person_id", bioguide)
        |> Map.put("lat", office["latitude"])
        |> Map.put("lon", office["longitude"])
        |> Map.put("statefp", Pyrex.FIPS.state_code!(office["state"]))
        |> Pyrex.Offices.create_district_office()
      end)
    end)
  end

  def shapes_and_jurisdictions do
    Enum.flat_map(Sources.shapefiles!(), fn {group_name, data} ->
      Enum.map(data["filenames"], fn filename ->
        fn ->
          filename
          |> Shapefile.map_download(data["base_url"])
          |> Enum.each(fn shape ->
            %Shape{}
            |> Shape.changeset(shape)
            |> insert(:shape)

            jurisdiction = build_jurisdiction_for(group_name, shape)

            %Jurisdiction{}
            |> Jurisdiction.changeset(jurisdiction)
            |> insert(:jurisdiction)
          end)
        end
      end)
    end)
    |> Task.async_stream(& &1.(), timeout: :infinity)
    |> Stream.run()
  end

  defp insert(changeset, type) do
    case Repo.insert(changeset, timeout: :infinity) do
      {:ok, record} ->
        Logger.info("Inserted #{type} with id #{record.id}")

      {:error, changeset} ->
        Logger.error(
          "Insertion of #{type} with id #{changeset.changes.geoid} failed " <>
            "with errors #{inspect(changeset.errors)}"
        )
    end
  end

  defp build_jurisdiction_for("congress", shape) do
    shape
    |> Map.drop([:geom])
    |> Map.put(:name, shape.namelsad)
    |> Map.put(:type, "us_cd")
  end

  defp build_jurisdiction_for("states", shape) do
    shape
    |> Map.drop([:geom])
    |> Map.put(:type, "us_state")
  end

  defp build_jurisdiction_for("state_legislative_districts_lower", shape) do
    shape
    |> Map.drop([:geom])
    |> Map.put(:name, shape.namelsad)
    |> Map.put(:type, "us_sldl")
  end

  defp build_jurisdiction_for("state_legislative_districts_upper", shape) do
    shape
    |> Map.drop([:geom])
    |> Map.put(:name, shape.namelsad)
    |> Map.put(:type, "us_sldu")
  end
end
