defmodule Pyrex.Officials.Term do
  @moduledoc """
  The database record for an elected official's term of office.
  """

  use Pyrex.Schema

  import Ecto.Changeset

  alias Pyrex.Repo

  schema "terms" do
    field :address, :string
    field :bioguide, :string
    field :class, :integer
    field :contact_form, :string
    field :current, :boolean
    field :district, :string
    field :end, :date
    field :geoid, :string
    field :office, :string
    field :party, :string
    field :person_id, :string
    field :phone, :string
    field :rss_url, :string
    field :start, :date
    field :state, :string
    field :statefp, :string
    field :state_rank, :string
    field :type, :string
    field :url, :string

    timestamps()
  end

  @cast_fields [
    :type,
    :start,
    :end,
    :state,
    :statefp,
    :district,
    :class,
    :party,
    :state_rank,
    :url,
    :rss_url,
    :contact_form,
    :address,
    :office,
    :phone,
    :current,
    :bioguide,
    :geoid
  ]

  @required_fields [
    :type,
    :start,
    :end,
    :state,
    :statefp,
    :current,
    :district,
    :bioguide,
    :geoid
  ]

  @type t :: %__MODULE__{
          address: String.t(),
          bioguide: String.t(),
          class: integer,
          contact_form: String.t(),
          current: boolean,
          district: String.t(),
          end: Date.t(),
          geoid: String.t(),
          office: String.t(),
          party: String.t(),
          person_id: String.t(),
          phone: String.t(),
          rss_url: String.t(),
          start: Date.t(),
          state: String.t(),
          statefp: String.t(),
          state_rank: String.t(),
          type: String.t(),
          url: String.t(),
          updated_at: NaiveDateTime.t(),
          inserted_at: NaiveDateTime.t()
        }

  @doc false
  def changeset(term, attrs) do
    term
    |> cast(attrs, @cast_fields)
    |> validate_required(@required_fields)
    |> generate_id()
    |> validate_required([:id])
    |> unique_constraint(:id, name: "terms_pkey")
    |> unsafe_validate_unique([:id], Repo)
  end

  defp generate_id(changeset) do
    bioguide = Map.get(changeset.changes, :bioguide, changeset.data.bioguide)
    start = Map.get(changeset.changes, :start, changeset.data.start)

    change(changeset, id: "#{bioguide}:#{start}")
  end
end
