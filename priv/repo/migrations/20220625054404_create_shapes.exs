defmodule PYREx.Repo.Local.Migrations.CreateShapes do
  use Ecto.Migration

  def change do
    create table(:shapes, primary_key: false) do
      add :id, :string, primary_key: true
      add :geoid, :string
      add :mtfcc, :string
      add :pyrgeoid, :string
      add :geom, :geometry

      timestamps()
    end
  end
end
