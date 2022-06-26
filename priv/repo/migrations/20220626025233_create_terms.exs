defmodule PYREx.Repo.Migrations.CreateTerms do
  use Ecto.Migration

  def change do
    create table(:terms, primary_key: false) do
      add :id, :string, primary_key: true
      add :type, :string
      add :start, :date
      add :end, :date
      add :state, :string
      add :district, :string
      add :class, :integer
      add :party, :string
      add :state_rank, :string
      add :url, :string
      add :rss_url, :string
      add :contact_form, :string
      add :address, :string
      add :office, :string
      add :phone, :string
      add :current, :boolean
      add :person_id, references(:people, type: :string, on_delete: :nothing)

      timestamps()
    end

    create index(:terms, [:person_id])
    create unique_index(:terms, [:id])
  end
end
