defmodule PYREx.Repo.Migrations.CreatePeople do
  use Ecto.Migration

  def change do
    create table(:people, primary_key: false) do
      add :id, :string, primary_key: true
      add :first, :string
      add :last, :string
      add :official_full, :string
      add :birthday, :date
      add :gender, :string

      timestamps()
    end

    create unique_index(:people, [:id])
  end
end
