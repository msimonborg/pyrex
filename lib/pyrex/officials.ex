defmodule PYREx.Officials do
  @moduledoc """
  The Officials context.
  """

  import Ecto.Query, warn: false
  alias PYREx.Repo

  alias PYREx.Officials.Person

  @doc """
  Returns the list of people.

  ## Examples

      iex> list_people()
      [%Person{}, ...]

  """
  def list_people do
    Repo.all(Person)
  end

  def list_current_people_for_location(location) do
    jurisdictions_query = PYREx.Geographies.intersecting_jurisdictions_query(location)

    query =
      from(p in Person,
        join: t in assoc(p, :terms),
        where: t.current == true,
        join: j in subquery(jurisdictions_query),
        on: j.geoid == t.geoid,
        left_join: o in assoc(p, :district_offices),
        preload: [current_term: t, district_offices: o]
      )

    Repo.all(query)
  end

  @doc """
  Gets a single person.

  Raises `Ecto.NoResultsError` if the Person does not exist.

  ## Examples

      iex> get_person!(123)
      %Person{}

      iex> get_person!(456)
      ** (Ecto.NoResultsError)

  """
  def get_person!(id), do: Repo.get!(Person, id)

  @doc """
  Creates a person.

  ## Examples

      iex> create_person(%{field: value})
      {:ok, %Person{}}

      iex> create_person(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_person(attrs \\ %{}) do
    %Person{}
    |> Person.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a person.

  ## Examples

      iex> update_person(person, %{field: new_value})
      {:ok, %Person{}}

      iex> update_person(person, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_person(%Person{} = person, attrs) do
    person
    |> Person.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Creates or updates a person based on the given ID.

  Raises with invalid data.

  ## Examples

      iex> create_or_update_person!(%{field: value})
      %Person{}
  """
  def create_or_update_person!(attrs \\ %{}) do
    id =
      attrs[:id] || attrs["id"] ||
        raise ArgumentError, "expected `id` attribute, got #{inspect(attrs)}"

    person = Person |> Repo.get(id) |> Repo.preload([:ids, :terms])

    case person do
      nil -> %Person{}
      person -> person
    end
    |> Person.changeset(attrs)
    |> Repo.insert_or_update!()
  end

  @doc """
  Deletes a person.

  ## Examples

      iex> delete_person(person)
      {:ok, %Person{}}

      iex> delete_person(person)
      {:error, %Ecto.Changeset{}}

  """
  def delete_person(%Person{} = person) do
    Repo.delete(person)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking person changes.

  ## Examples

      iex> change_person(person)
      %Ecto.Changeset{data: %Person{}}

  """
  def change_person(%Person{} = person, attrs \\ %{}) do
    Person.changeset(person, attrs)
  end

  alias PYREx.Officials.ID

  @doc """
  Returns the list of ids.

  ## Examples

      iex> list_ids()
      [%ID{}, ...]

  """
  def list_ids do
    Repo.all(ID)
  end

  @doc """
  Gets a single id.

  Raises `Ecto.NoResultsError` if the Id does not exist.

  ## Examples

      iex> get_id!(123)
      %ID{}

      iex> get_id!(456)
      ** (Ecto.NoResultsError)

  """
  def get_id!(id), do: Repo.get!(ID, id)

  @doc """
  Creates a id.

  ## Examples

      iex> create_id(%{field: value})
      {:ok, %ID{}}

      iex> create_id(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_id(attrs \\ %{}) do
    %ID{}
    |> ID.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a id.

  ## Examples

      iex> update_id(id, %{field: new_value})
      {:ok, %ID{}}

      iex> update_id(id, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_id(%ID{} = id, attrs) do
    id
    |> ID.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a id.

  ## Examples

      iex> delete_id(id)
      {:ok, %ID{}}

      iex> delete_id(id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_id(%ID{} = id) do
    Repo.delete(id)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking id changes.

  ## Examples

      iex> change_id(id)
      %Ecto.Changeset{data: %ID{}}

  """
  def change_id(%ID{} = id, attrs \\ %{}) do
    ID.changeset(id, attrs)
  end

  alias PYREx.Officials.Term

  @doc """
  Returns the list of terms.

  ## Examples

      iex> list_terms()
      [%Term{}, ...]

  """
  def list_terms do
    Repo.all(Term)
  end

  @doc """
  Gets a single term.

  Raises `Ecto.NoResultsError` if the Term does not exist.

  ## Examples

      iex> get_term!(123)
      %Term{}

      iex> get_term!(456)
      ** (Ecto.NoResultsError)

  """
  def get_term!(id), do: Repo.get!(Term, id)

  @doc """
  Creates a term.

  ## Examples

      iex> create_term(%{field: value})
      {:ok, %Term{}}

      iex> create_term(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_term(attrs \\ %{}) do
    %Term{}
    |> Term.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a term.

  ## Examples

      iex> update_term(term, %{field: new_value})
      {:ok, %Term{}}

      iex> update_term(term, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_term(%Term{} = term, attrs) do
    term
    |> Term.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a term.

  ## Examples

      iex> delete_term(term)
      {:ok, %Term{}}

      iex> delete_term(term)
      {:error, %Ecto.Changeset{}}

  """
  def delete_term(%Term{} = term) do
    Repo.delete(term)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking term changes.

  ## Examples

      iex> change_term(term)
      %Ecto.Changeset{data: %Term{}}

  """
  def change_term(%Term{} = term, attrs \\ %{}) do
    Term.changeset(term, attrs)
  end
end
