defmodule PYREx.Offices do
  @moduledoc """
  The Offices context.
  """

  import Ecto.Query, warn: false
  alias PYREx.Repo

  alias PYREx.Offices.DistrictOffice

  @doc """
  Returns the list of district offices.

  ## Examples

      iex> list_district_offices()
      [%DistrictOffice{}, ...]

  """
  def list_district_offices do
    Repo.all(DistrictOffice)
  end

  @doc """
  Gets a single district office.

  Raises `Ecto.NoResultsError` if the Office does not exist.

  ## Examples

      iex> get_district_office!(123)
      %DistrictOffice{}

      iex> get_district_office!(456)
      ** (Ecto.NoResultsError)

  """
  def get_district_office!(id), do: Repo.get!(DistrictOffice, id)

  @doc """
  Creates a district office.

  ## Examples

      iex> create_district_office(%{field: value})
      {:ok, %DistrictOffice{}}

      iex> create_district_office(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_district_office(attrs \\ %{}) do
    %DistrictOffice{}
    |> DistrictOffice.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a district office.

  ## Examples

      iex> update_district_office(district_office, %{field: new_value})
      {:ok, %DistrictOffice{}}

      iex> update_district_office(district_office, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_district_office(%DistrictOffice{} = district_office, attrs) do
    district_office
    |> DistrictOffice.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Creates or updates a district office based on the given ID.

  Raises with invalid data.

  ## Examples

      iex> create_or_update_district_office!(%{field: value})
      %DistrictOffice{}
  """
  def create_or_update_district_office!(attrs \\ %{}) do
    id =
      attrs[:id] || attrs["id"] ||
        raise ArgumentError, "expected `id` attribute, got #{inspect(attrs)}"

    case Repo.get(DistrictOffice, id) do
      nil -> %DistrictOffice{}
      district_office -> district_office
    end
    |> change_district_office(attrs)
    |> Repo.insert_or_update!()
  end

  @doc """
  Deletes a district office.

  ## Examples

      iex> delete_district_office(district_office)
      {:ok, %DistrictOffice{}}

      iex> delete_district_office(district_office)
      {:error, %Ecto.Changeset{}}

  """
  def delete_district_office(%DistrictOffice{} = district_office) do
    Repo.delete(district_office)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking district office changes.

  ## Examples

      iex> change_district_office(district_office)
      %Ecto.Changeset{data: %DistrictOffice{}}

  """
  def change_district_office(%DistrictOffice{} = district_office, attrs \\ %{}) do
    DistrictOffice.changeset(district_office, attrs)
  end
end
