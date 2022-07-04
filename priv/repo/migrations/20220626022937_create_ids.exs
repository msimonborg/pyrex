defmodule Pyrex.Repo.Migrations.CreateIds do
  use Ecto.Migration

  def change do
    create table(:ids, primary_key: false) do
      add :id, :string, primary_key: true
      add :type, :string
      add :value, :string
      add :person_id, references(:people, type: :string, on_delete: :delete_all)

      timestamps()
    end

    create index(:ids, [:person_id])
    create unique_index(:ids, [:id])
  end
end
