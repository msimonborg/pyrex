defmodule PYREx.Repo.Local.Migrations.AddGeoidToTerms do
  use Ecto.Migration

  def change do
    alter table(:terms) do
      add :geoid, :string
    end

    create index(:terms, [:geoid])
  end
end
