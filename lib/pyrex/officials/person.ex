defmodule Pyrex.Officials.Person do
  @moduledoc """
  A schema for elected officials.
  """

  use Pyrex.Schema

  import Ecto.Changeset

  alias Pyrex.Officials.{ID, Term}
  alias Pyrex.{Offices.DistrictOffice, Repo}

  schema "people" do
    field :birthday, :date
    field :first, :string
    field :gender, :string
    field :last, :string
    field :official_full, :string

    has_many :ids, ID, on_replace: :delete

    has_many :terms, Term, on_replace: :delete
    has_one :current_term, Term, where: [current: true]

    has_many :district_offices, DistrictOffice

    timestamps()
  end

  @type t :: %__MODULE__{
          birthday: Date.t(),
          first: String.t(),
          gender: String.t(),
          last: String.t(),
          official_full: String.t(),
          updated_at: NaiveDateTime.t(),
          inserted_at: NaiveDateTime.t()
        }

  @doc false
  def changeset(person, attrs) do
    person
    |> cast(attrs, [:id, :first, :last, :official_full, :birthday, :gender])
    |> validate_required([:id, :first, :last, :official_full, :birthday, :gender])
    |> cast_assoc(:terms)
    |> cast_assoc(:ids)
    |> unique_constraint(:id, name: "people_pkey")
    |> unsafe_validate_unique([:id], Repo)
  end
end
