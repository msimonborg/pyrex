defmodule PYREx.Repo.Local.Migrations.AddGeomToDistrictOffices do
  use Ecto.Migration

  def change do
    alter table(:district_offices) do
      add :geom, :geometry
    end
  end
end
