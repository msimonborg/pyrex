defmodule PYREx.Loader do
  # credo:disable-for-this-file
  require Logger
  alias PYREx.Shapefile
  alias PYREx.Geographies.{Shape, Jurisdiction}
  alias PYREx.Repo

  defp insert(item, type) do
    case Repo.insert(item) do
      {:ok, item} ->
        Logger.info("Inserted #{type} with id #{item.id}")

      {:error, changeset} ->
        Logger.error("Failed with errors #{inspect(changeset.errors)}")
    end
  end

  def run do
    shapefiles = PYREx.Sources.shapefiles()
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
end
