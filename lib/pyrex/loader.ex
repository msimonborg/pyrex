defmodule PYREx.Loader do
  # credo:disable-for-this-file
  require Logger
  alias PYREx.{Repo, Shapefile, Sources}
  alias PYREx.Geographies.{Shape, Jurisdiction}

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
      |> PYREx.Officials.create_or_update_person!()
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
      statefp = PYREx.FIPS.state_code(term["state"])

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
        |> Map.put("statefp", PYREx.FIPS.state_code(office["state"]))
        |> PYREx.Offices.create_district_office()
      end)
    end)
  end

  def shapes_and_jurisdictions do
    shapefiles = Sources.shapefiles!()
    congress = shapefiles["congress"]
    states = shapefiles["states"]
    sldl = shapefiles["state_legislative_districts_lower"]
    sldu = shapefiles["state_legislative_districts_upper"]

    congress_tasks =
      Enum.map(congress["filenames"], fn filename ->
        fn ->
          filename
          |> Shapefile.map_download(congress["base_url"])
          |> Enum.each(fn shape ->
            Shape.changeset(%Shape{}, shape)
            |> insert(:shape)

            jurisdiction =
              shape
              |> Map.drop([:geom])
              |> Map.put(:name, shape.namelsad)
              |> Map.put(:type, "us_cd")

            Jurisdiction.changeset(%Jurisdiction{}, jurisdiction)
            |> insert(:jurisdiction)
          end)
        end
      end)

    states_tasks =
      Enum.map(states["filenames"], fn filename ->
        fn ->
          filename
          |> Shapefile.map_download(states["base_url"])
          |> Enum.map(fn shape ->
            Shape.changeset(%Shape{}, shape)
            |> insert(:shape)

            jurisdiction =
              shape
              |> Map.drop([:geom])
              |> Map.put(:type, "us_state")

            Jurisdiction.changeset(%Jurisdiction{}, jurisdiction)
            |> insert(:jurisdiction)
          end)
        end
      end)

    sldl_tasks =
      Enum.map(sldl["filenames"], fn filename ->
        fn ->
          filename
          |> Shapefile.map_download(sldl["base_url"])
          |> Enum.each(fn shape ->
            Shape.changeset(%Shape{}, shape)
            |> insert(:shape)

            jurisdiction =
              shape
              |> Map.drop([:geom])
              |> Map.put(:name, shape.namelsad)
              |> Map.put(:type, "us_sldl")

            Jurisdiction.changeset(%Jurisdiction{}, jurisdiction)
            |> insert(:jurisdiction)
          end)
        end
      end)

    sldu_tasks =
      Enum.map(sldu["filenames"], fn filename ->
        fn ->
          filename
          |> Shapefile.map_download(sldu["base_url"])
          |> Enum.each(fn shape ->
            Shape.changeset(%Shape{}, shape)
            |> insert(:shape)

            jurisdiction =
              shape
              |> Map.drop([:geom])
              |> Map.put(:name, shape.namelsad)
              |> Map.put(:type, "us_sldu")

            Jurisdiction.changeset(%Jurisdiction{}, jurisdiction)
            |> insert(:jurisdiction)
          end)
        end
      end)

    [congress_tasks, states_tasks, sldl_tasks, sldu_tasks]
    |> List.flatten()
    |> Task.async_stream(fn task -> task.() end, timeout: :infinity)
    |> Stream.run()
  end

  defp insert(item, type) do
    case Repo.insert(item) do
      {:ok, item} ->
        Logger.info("Inserted #{type} with id #{item.id}")

      {:error, changeset} ->
        Logger.error(
          "Insertion of #{type} with id #{item.id} failed " <>
            "with errors #{inspect(changeset.errors)}"
        )
    end
  end
end
