defmodule PYREx.Repo.Migrations.CreateDistrictOffices do
  use Ecto.Migration

  def change do
    create table(:district_offices, primary_key: false) do
      add :id, :string, primary_key: true
      add :address, :string
      add :suite, :string
      add :city, :string
      add :state, :string
      add :statefp, :string
      add :zip, :string
      add :lat, :float
      add :lon, :float
      add :phone, :string
      add :fax, :string
      add :building, :string
      add :hours, :string
      add :person_id, references(:people, type: :string, on_delete: :delete_all)

      timestamps()
    end

    create index(:district_offices, [:person_id])
  end
end
