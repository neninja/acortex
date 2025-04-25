defmodule AcorteWeb.EventController do
  use AcorteWeb, :controller

  alias Acorte.Events
  alias Acorte.Events.Event

  # Adicione esta linha
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    events = Events.list_events()
    render(conn, :index, events: events)
  end

  def new(conn, _params) do
    changeset = Events.change_event(%Event{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"event" => event_params}) do
    case Events.create_event(event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event created successfully.")
        |> redirect(to: ~p"/events/#{event}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    event =
      Acorte.Repo.get!(Event, id)
      |> Acorte.Repo.preload(polls: [:options])

    user_votes =
      Acorte.Repo.all(
        from v in Acorte.Polls.Vote,
          where: v.user_id == ^conn.assigns.current_user.id,
          select: %{poll_option_id: v.poll_option_id, is_favorite: v.is_favorite}
      )

    user_votes_ids = Enum.map(user_votes, & &1.poll_option_id)

    favorite_votes_ids =
      Enum.map(user_votes, fn vote -> if vote.is_favorite, do: vote.poll_option_id end)
      |> Enum.reject(&is_nil/1)

    other_user_votes =
      Acorte.Repo.all(
        from v in Acorte.Polls.Vote,
          join: u in assoc(v, :user),
          where: v.user_id != ^conn.assigns.current_user.id,
          select: %{poll_option_id: v.poll_option_id, user_name: u.name}
      )

    other_votes_by_option =
      other_user_votes
      |> Enum.group_by(& &1.poll_option_id, & &1.user_name)

    render(conn, "show.html",
      event: event,
      my_votes: user_votes_ids,
      my_favorite_votes: favorite_votes_ids,
      other_votes_by_option: other_votes_by_option
    )
  end

  def edit(conn, %{"id" => id}) do
    event = Events.get_event(id)
    changeset = Events.change_event(event)
    render(conn, :edit, event: event, changeset: changeset)
  end

  def update(conn, %{"id" => id, "event" => event_params}) do
    event = Events.get_event(id)

    case Events.update_event(event, event_params) do
      {:ok, event} ->
        conn
        |> put_flash(:info, "Event updated successfully.")
        |> redirect(to: ~p"/events/#{event}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, event: event, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    event = Events.get_event(id)
    {:ok, _event} = Events.delete_event(event)

    conn
    |> put_flash(:info, "Event deleted successfully.")
    |> redirect(to: ~p"/events")
  end
end
