defmodule Acorte.Polls do
  @moduledoc """
  The Polls context.
  """

  import Ecto.Query, warn: false
  alias Acorte.Repo

  alias Acorte.Polls.Poll

  @doc """
  Returns the list of polls.

  ## Examples

      iex> list_polls()
      [%Poll{}, ...]

  """
  def list_polls do
    Repo.all(Poll)
  end

  @doc """
  Gets a single poll.

  Raises `Ecto.NoResultsError` if the Poll does not exist.

  ## Examples

      iex> get_poll!(123)
      %Poll{}

      iex> get_poll!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poll!(id), do: Repo.get!(Poll, id)

  @doc """
  Creates a poll.

  ## Examples

      iex> create_poll(%{field: value})
      {:ok, %Poll{}}

      iex> create_poll(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poll(attrs \\ %{}) do
    %Poll{}
    |> Poll.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poll.

  ## Examples

      iex> update_poll(poll, %{field: new_value})
      {:ok, %Poll{}}

      iex> update_poll(poll, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poll(%Poll{} = poll, attrs) do
    poll
    |> Poll.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poll.

  ## Examples

      iex> delete_poll(poll)
      {:ok, %Poll{}}

      iex> delete_poll(poll)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poll(%Poll{} = poll) do
    Repo.delete(poll)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poll changes.

  ## Examples

      iex> change_poll(poll)
      %Ecto.Changeset{data: %Poll{}}

  """
  def change_poll(%Poll{} = poll, attrs \\ %{}) do
    Poll.changeset(poll, attrs)
  end

  alias Acorte.Polls.PollOption

  @doc """
  Returns the list of poll_options.

  ## Examples

      iex> list_poll_options()
      [%PollOption{}, ...]

  """
  def list_poll_options do
    Repo.all(PollOption)
  end

  @doc """
  Gets a single poll_option.

  Raises `Ecto.NoResultsError` if the Poll option does not exist.

  ## Examples

      iex> get_poll_option!(123)
      %PollOption{}

      iex> get_poll_option!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poll_option!(id), do: Repo.get!(PollOption, id)

  @doc """
  Creates a poll_option.

  ## Examples

      iex> create_poll_option(%{field: value})
      {:ok, %PollOption{}}

      iex> create_poll_option(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poll_option(attrs \\ %{}) do
    %PollOption{}
    |> PollOption.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poll_option.

  ## Examples

      iex> update_poll_option(poll_option, %{field: new_value})
      {:ok, %PollOption{}}

      iex> update_poll_option(poll_option, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poll_option(%PollOption{} = poll_option, attrs) do
    poll_option
    |> PollOption.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a poll_option.

  ## Examples

      iex> delete_poll_option(poll_option)
      {:ok, %PollOption{}}

      iex> delete_poll_option(poll_option)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poll_option(%PollOption{} = poll_option) do
    Repo.delete(poll_option)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poll_option changes.

  ## Examples

      iex> change_poll_option(poll_option)
      %Ecto.Changeset{data: %PollOption{}}

  """
  def change_poll_option(%PollOption{} = poll_option, attrs \\ %{}) do
    PollOption.changeset(poll_option, attrs)
  end

  alias Acorte.Polls.Vote

  @doc """
  Returns the list of votes.

  ## Examples

      iex> list_votes()
      [%Vote{}, ...]

  """
  def list_votes do
    Repo.all(Vote)
  end

  @doc """
  Gets a single vote.

  Raises `Ecto.NoResultsError` if the Vote does not exist.

  ## Examples

      iex> get_vote!(123)
      %Vote{}

      iex> get_vote!(456)
      ** (Ecto.NoResultsError)

  """
  def get_vote!(id), do: Repo.get!(Vote, id)

  @doc """
  Creates a vote.

  ## Examples

      iex> create_vote(%{field: value})
      {:ok, %Vote{}}

      iex> create_vote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vote(attrs \\ %{}) do
    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vote.

  ## Examples

      iex> update_vote(vote, %{field: new_value})
      {:ok, %Vote{}}

      iex> update_vote(vote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vote(%Vote{} = vote, attrs) do
    vote
    |> Vote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a vote.

  ## Examples

      iex> delete_vote(vote)
      {:ok, %Vote{}}

      iex> delete_vote(vote)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vote(%Vote{} = vote) do
    Repo.delete(vote)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vote changes.

  ## Examples

      iex> change_vote(vote)
      %Ecto.Changeset{data: %Vote{}}

  """
  def change_vote(%Vote{} = vote, attrs \\ %{}) do
    Vote.changeset(vote, attrs)
  end
end
