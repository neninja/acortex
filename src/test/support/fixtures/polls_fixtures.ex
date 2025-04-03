defmodule Acorte.PollsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Acorte.Polls` context.
  """

  @doc """
  Generate a poll.
  """
  def poll_fixture(attrs \\ %{}) do
    {:ok, poll} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Acorte.Polls.create_poll()

    poll
  end

  @doc """
  Generate a poll_option.
  """
  def poll_option_fixture(attrs \\ %{}) do
    {:ok, poll_option} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Acorte.Polls.create_poll_option()

    poll_option
  end

  @doc """
  Generate a vote.
  """
  def vote_fixture(attrs \\ %{}) do
    {:ok, vote} =
      attrs
      |> Enum.into(%{
        description: "some description",
        title: "some title"
      })
      |> Acorte.Polls.create_vote()

    vote
  end
end
