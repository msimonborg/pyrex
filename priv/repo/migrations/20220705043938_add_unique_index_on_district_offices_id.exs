defmodule Pyrex.Repo.Local.Migrations.AddUniqueIndexOnDistrictOfficesId do
  use Ecto.Migration

  def change do
    create unique_index(:district_offices, [:id])
  end
end
