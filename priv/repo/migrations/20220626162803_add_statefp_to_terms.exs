defmodule PYREx.Repo.Local.Migrations.AddStatefpToTerms do
  use Ecto.Migration

  def change do
    alter table(:terms) do
      add :statefp, :string
    end

    create index(:terms, [:statefp])
  end
end
