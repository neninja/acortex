defmodule Acorte.OccasionsTest do
  use Acorte.DataCase

  alias Acorte.Occasions

  describe "occasions" do
    alias Acorte.Occasions.Occasion

    import Acorte.OccasionsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_occasions/0 returns all occasions" do
      occasion = occasion_fixture()
      assert Occasions.list_occasions() == [occasion]
    end

    test "get_occasion!/1 returns the occasion with given id" do
      occasion = occasion_fixture()
      assert Occasions.get_occasion!(occasion.id) == occasion
    end

    test "create_occasion/1 with valid data creates a occasion" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Occasion{} = occasion} = Occasions.create_occasion(valid_attrs)
      assert occasion.description == "some description"
      assert occasion.title == "some title"
    end

    test "create_occasion/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Occasions.create_occasion(@invalid_attrs)
    end

    test "update_occasion/2 with valid data updates the occasion" do
      occasion = occasion_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Occasion{} = occasion} = Occasions.update_occasion(occasion, update_attrs)
      assert occasion.description == "some updated description"
      assert occasion.title == "some updated title"
    end

    test "update_occasion/2 with invalid data returns error changeset" do
      occasion = occasion_fixture()
      assert {:error, %Ecto.Changeset{}} = Occasions.update_occasion(occasion, @invalid_attrs)
      assert occasion == Occasions.get_occasion!(occasion.id)
    end

    test "delete_occasion/1 deletes the occasion" do
      occasion = occasion_fixture()
      assert {:ok, %Occasion{}} = Occasions.delete_occasion(occasion)
      assert_raise Ecto.NoResultsError, fn -> Occasions.get_occasion!(occasion.id) end
    end

    test "change_occasion/1 returns a occasion changeset" do
      occasion = occasion_fixture()
      assert %Ecto.Changeset{} = Occasions.change_occasion(occasion)
    end
  end
end
