defmodule Acorte.EventsTest do
  use Acorte.DataCase

  alias Acorte.Events

  describe "events" do
    alias Acorte.Events.Event

    import Acorte.EventsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %event{} = event} = Events.create_event(valid_attrs)
      assert event.description == "some description"
      assert event.title == "some title"
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Event{} = event} = Events.update_event(event, update_attrs)
      assert event.description == "some updated description"
      assert event.title == "some updated title"
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end
end
