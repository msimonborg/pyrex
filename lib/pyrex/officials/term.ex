defmodule PYREx.Officials.Term do
  @moduledoc """
  The database record for an elected official's term of office.
  """

  use PYREx.Schema

  import Ecto.Changeset

  alias PYREx.{Officials.Person, Repo}

  schema "terms" do
    field :address, :string
    field :class, :integer
    field :contact_form, :string
    field :current, :boolean
    field :district, :string
    field :end, :date
    field :office, :string
    field :party, :string
    field :phone, :string
    field :rss_url, :string
    field :start, :date
    field :state, :string
    field :state_rank, :string
    field :type, :string
    field :url, :string

    belongs_to :person, Person

    timestamps()
  end

  @cast_fields [
    :type,
    :start,
    :end,
    :state,
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
    :current
  ]

  @required_fields [
    :type,
    :start,
    :end,
    :state,
    :current,
    :district
  ]

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
    state = Map.get(changeset.changes, :state, changeset.data.state)
    type = Map.get(changeset.changes, :type, changeset.data.type)
    start = Map.get(changeset.changes, :start, changeset.data.start)
    district = Map.get(changeset.changes, :district, changeset.data.district)

    change(changeset, id: "#{state}:#{type}:#{district}:#{start}")
  end
end
