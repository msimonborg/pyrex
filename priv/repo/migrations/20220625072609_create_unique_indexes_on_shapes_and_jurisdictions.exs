defmodule Pyrex.Repo.Local.Migrations.CreateUniqueIndexesOnShapesAndJurisdictions do
  use Ecto.Migration

  def change do
    create unique_index("shapes", [:id])
    create unique_index("jurisdictions", [:id])
  end
end
