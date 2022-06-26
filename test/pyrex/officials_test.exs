defmodule PYREx.OfficialsTest do
  use PYREx.DataCase

  alias PYREx.Officials

  describe "people" do
    alias PYREx.Officials.Person

    import PYREx.OfficialsFixtures

    @invalid_attrs %{birthday: nil, first: nil, gender: nil, last: nil, official_full: nil}

    test "list_people/0 returns all people" do
      person = person_fixture()
      assert Officials.list_people() == [person]
    end

    test "get_person!/1 returns the person with given id" do
      person = person_fixture()
      assert Officials.get_person!(person.id) == person
    end

    test "create_person/1 with valid data creates a person" do
      valid_attrs = %{
        id: "some id",
        birthday: ~D[2022-06-25],
        first: "some first",
        gender: "some gender",
        last: "some last",
        official_full: "some official_full"
      }

      assert {:ok, %Person{} = person} = Officials.create_person(valid_attrs)
      assert person.id == "some id"
      assert person.birthday == ~D[2022-06-25]
      assert person.first == "some first"
      assert person.gender == "some gender"
      assert person.last == "some last"
      assert person.official_full == "some official_full"
    end

    test "create_person/1 with associated data creates associations" do
      assert {:ok, %Person{} = person} = Officials.create_person(person_attrs_with_associations())
      assert Officials.list_ids() == person.ids
      assert Officials.list_terms() == person.terms
    end

    test "create_person/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Officials.create_person(@invalid_attrs)
    end

    test "create_or_update_person!/1 creates or updates a person and associations" do
      attrs = person_attrs_with_associations()
      assert %Person{} = person = Officials.create_or_update_person!(attrs)
      assert Officials.list_ids() == person.ids
      assert Officials.list_terms() == person.terms

      attrs = Map.replace(attrs, "ids", [])

      assert %Person{} = person = Officials.create_or_update_person!(attrs)
      assert Officials.list_ids() == person.ids
    end

    test "create_or_update_person!/1 raises with invalid data" do
      invalid_attrs = Map.replace(person_attrs_with_associations(), "ids", [%{invalid: "data"}])

      assert_raise(Ecto.InvalidChangesetError, fn ->
        Officials.create_or_update_person!(invalid_attrs)
      end)
    end

    test "update_person/2 with valid data updates the person" do
      person = person_fixture()

      update_attrs = %{
        id: "some id",
        birthday: ~D[2022-06-26],
        first: "some updated first",
        gender: "some updated gender",
        last: "some updated last",
        official_full: "some updated official_full"
      }

      assert {:ok, %Person{} = person} = Officials.update_person(person, update_attrs)
      assert person.id == "some id"
      assert person.birthday == ~D[2022-06-26]
      assert person.first == "some updated first"
      assert person.gender == "some updated gender"
      assert person.last == "some updated last"
      assert person.official_full == "some updated official_full"
    end

    test "update_person/2 with invalid data returns error changeset" do
      person = person_fixture()
      assert {:error, %Ecto.Changeset{}} = Officials.update_person(person, @invalid_attrs)
      assert person == Officials.get_person!(person.id)
    end

    test "delete_person/1 deletes the person" do
      person = person_fixture()
      assert {:ok, %Person{}} = Officials.delete_person(person)
      assert_raise Ecto.NoResultsError, fn -> Officials.get_person!(person.id) end
    end

    test "change_person/1 returns a person changeset" do
      person = person_fixture()
      assert %Ecto.Changeset{} = Officials.change_person(person)
    end
  end

  describe "ids" do
    alias PYREx.Officials.ID

    import PYREx.OfficialsFixtures

    @invalid_attrs %{type: nil, value: nil}

    test "list_ids/0 returns all ids" do
      id = id_fixture()
      assert Officials.list_ids() == [id]
    end

    test "get_id!/1 returns the id with given id" do
      id = id_fixture()
      assert Officials.get_id!(id.id) == id
    end

    test "create_id/1 with valid data creates a id" do
      valid_attrs = %{type: "some type", value: "some value"}

      assert {:ok, %ID{} = id} = Officials.create_id(valid_attrs)
      assert id.id == "some type:some value"
      assert id.type == "some type"
      assert id.value == "some value"
    end

    test "create_id/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Officials.create_id(@invalid_attrs)
    end

    test "update_id/2 with valid data updates the id" do
      id = id_fixture()
      update_attrs = %{type: "some updated type", value: "some updated value"}

      assert {:ok, %ID{} = id} = Officials.update_id(id, update_attrs)
      assert id.id == "some updated type:some updated value"
      assert id.type == "some updated type"
      assert id.value == "some updated value"
    end

    test "update_id/2 with invalid data returns error changeset" do
      id = id_fixture()
      assert {:error, %Ecto.Changeset{}} = Officials.update_id(id, @invalid_attrs)
      assert id == Officials.get_id!(id.id)
    end

    test "delete_id/1 deletes the id" do
      id = id_fixture()
      assert {:ok, %ID{}} = Officials.delete_id(id)
      assert_raise Ecto.NoResultsError, fn -> Officials.get_id!(id.id) end
    end

    test "change_id/1 returns a id changeset" do
      id = id_fixture()
      assert %Ecto.Changeset{} = Officials.change_id(id)
    end
  end

  describe "terms" do
    alias PYREx.Officials.Term

    import PYREx.OfficialsFixtures

    @invalid_attrs %{
      person_id: nil,
      address: nil,
      class: nil,
      contact_form: nil,
      district: nil,
      end: nil,
      office: nil,
      party: nil,
      phone: nil,
      rss_url: nil,
      start: nil,
      state: nil,
      state_rank: nil,
      type: nil,
      url: nil,
      current: nil
    }

    test "list_terms/0 returns all terms" do
      term = term_fixture()
      assert Officials.list_terms() == [term]
    end

    test "get_term!/1 returns the term with given id" do
      term = term_fixture()
      assert Officials.get_term!(term.id) == term
    end

    test "create_term/1 with valid data creates a term" do
      valid_attrs = %{
        bioguide: "some bioguide",
        address: "some address",
        class: 42,
        contact_form: "some contact_form",
        district: "some district",
        end: ~D[2022-06-25],
        office: "some office",
        party: "some party",
        phone: "some phone",
        rss_url: "some rss_url",
        start: ~D[2022-06-25],
        state: "some state",
        state_rank: "some state_rank",
        type: "some type",
        url: "some url",
        current: true
      }

      assert {:ok, %Term{} = term} = Officials.create_term(valid_attrs)
      assert term.id == "some bioguide:2022-06-25"
      assert term.address == "some address"
      assert term.class == 42
      assert term.contact_form == "some contact_form"
      assert term.district == "some district"
      assert term.end == ~D[2022-06-25]
      assert term.office == "some office"
      assert term.party == "some party"
      assert term.phone == "some phone"
      assert term.rss_url == "some rss_url"
      assert term.start == ~D[2022-06-25]
      assert term.state == "some state"
      assert term.state_rank == "some state_rank"
      assert term.type == "some type"
      assert term.url == "some url"
      assert term.current == true
    end

    test "create_term/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Officials.create_term(@invalid_attrs)
    end

    test "update_term/2 with valid data updates the term" do
      term = term_fixture()

      update_attrs = %{
        bioguide: "some updated bioguide",
        address: "some updated address",
        class: 43,
        contact_form: "some updated contact_form",
        district: "some updated district",
        end: ~D[2022-06-26],
        office: "some updated office",
        party: "some updated party",
        phone: "some updated phone",
        rss_url: "some updated rss_url",
        start: ~D[2022-06-26],
        state: "some updated state",
        state_rank: "some updated state_rank",
        type: "some updated type",
        url: "some updated url",
        current: false
      }

      assert {:ok, %Term{} = term} = Officials.update_term(term, update_attrs)
      assert term.id == "some updated bioguide:2022-06-26"
      assert term.address == "some updated address"
      assert term.class == 43
      assert term.contact_form == "some updated contact_form"
      assert term.district == "some updated district"
      assert term.end == ~D[2022-06-26]
      assert term.office == "some updated office"
      assert term.party == "some updated party"
      assert term.phone == "some updated phone"
      assert term.rss_url == "some updated rss_url"
      assert term.start == ~D[2022-06-26]
      assert term.state == "some updated state"
      assert term.state_rank == "some updated state_rank"
      assert term.type == "some updated type"
      assert term.url == "some updated url"
      assert term.current == false
    end

    test "update_term/2 with invalid data returns error changeset" do
      term = term_fixture()
      assert {:error, %Ecto.Changeset{}} = Officials.update_term(term, @invalid_attrs)
      assert term == Officials.get_term!(term.id)
    end

    test "delete_term/1 deletes the term" do
      term = term_fixture()
      assert {:ok, %Term{}} = Officials.delete_term(term)
      assert_raise Ecto.NoResultsError, fn -> Officials.get_term!(term.id) end
    end

    test "change_term/1 returns a term changeset" do
      term = term_fixture()
      assert %Ecto.Changeset{} = Officials.change_term(term)
    end
  end
end
