defmodule Acorte.PollsTest do
  use Acorte.DataCase

  alias Acorte.Polls

  describe "polls" do
    alias Acorte.Polls.Poll

    import Acorte.PollsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_polls/0 returns all polls" do
      poll = poll_fixture()
      assert Polls.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = poll_fixture()
      assert Polls.get_poll!(poll.id) == poll
    end

    test "create_poll/1 with valid data creates a poll" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Poll{} = poll} = Polls.create_poll(valid_attrs)
      assert poll.description == "some description"
      assert poll.title == "some title"
    end

    test "create_poll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll(@invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = poll_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Poll{} = poll} = Polls.update_poll(poll, update_attrs)
      assert poll.description == "some updated description"
      assert poll.title == "some updated title"
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll(poll, @invalid_attrs)
      assert poll == Polls.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{}} = Polls.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = poll_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll(poll)
    end
  end

  describe "poll_options" do
    alias Acorte.Polls.PollOption

    import Acorte.PollsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_poll_options/0 returns all poll_options" do
      poll_option = poll_option_fixture()
      assert Polls.list_poll_options() == [poll_option]
    end

    test "get_poll_option!/1 returns the poll_option with given id" do
      poll_option = poll_option_fixture()
      assert Polls.get_poll_option!(poll_option.id) == poll_option
    end

    test "create_poll_option/1 with valid data creates a poll_option" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %PollOption{} = poll_option} = Polls.create_poll_option(valid_attrs)
      assert poll_option.description == "some description"
      assert poll_option.title == "some title"
    end

    test "create_poll_option/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_poll_option(@invalid_attrs)
    end

    test "update_poll_option/2 with valid data updates the poll_option" do
      poll_option = poll_option_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %PollOption{} = poll_option} = Polls.update_poll_option(poll_option, update_attrs)
      assert poll_option.description == "some updated description"
      assert poll_option.title == "some updated title"
    end

    test "update_poll_option/2 with invalid data returns error changeset" do
      poll_option = poll_option_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_poll_option(poll_option, @invalid_attrs)
      assert poll_option == Polls.get_poll_option!(poll_option.id)
    end

    test "delete_poll_option/1 deletes the poll_option" do
      poll_option = poll_option_fixture()
      assert {:ok, %PollOption{}} = Polls.delete_poll_option(poll_option)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_poll_option!(poll_option.id) end
    end

    test "change_poll_option/1 returns a poll_option changeset" do
      poll_option = poll_option_fixture()
      assert %Ecto.Changeset{} = Polls.change_poll_option(poll_option)
    end
  end

  describe "votes" do
    alias Acorte.Polls.Vote

    import Acorte.PollsFixtures

    @invalid_attrs %{description: nil, title: nil}

    test "list_votes/0 returns all votes" do
      vote = vote_fixture()
      assert Polls.list_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Polls.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      valid_attrs = %{description: "some description", title: "some title"}

      assert {:ok, %Vote{} = vote} = Polls.create_vote(valid_attrs)
      assert vote.description == "some description"
      assert vote.title == "some title"
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polls.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      update_attrs = %{description: "some updated description", title: "some updated title"}

      assert {:ok, %Vote{} = vote} = Polls.update_vote(vote, update_attrs)
      assert vote.description == "some updated description"
      assert vote.title == "some updated title"
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Polls.update_vote(vote, @invalid_attrs)
      assert vote == Polls.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Polls.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Polls.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Polls.change_vote(vote)
    end
  end
end
