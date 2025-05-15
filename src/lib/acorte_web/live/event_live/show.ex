defmodule AcorteWeb.EventLive.Show do
  use AcorteWeb, :live_view

  alias Acorte.Events.Event
  alias Acorte.Repo
  import Ecto.Query, only: [from: 2]

  defp subscribe(event) do
    Phoenix.PubSub.subscribe(Acorte.PubSub, "event:#{event.id}")
  end

  defp broadcast(event, value) do
    Phoenix.PubSub.broadcast(
      Acorte.PubSub,
      "event:#{event.id}",
      value
    )
  end

  def handle_info({:vote_updated, _user_id, updated_votes}, socket) do
    {:noreply, assign(socket, my_votes: updated_votes)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, event: nil, my_votes: [])}
  end

  def handle_params(%{"id" => id}, _, %{assigns: %{current_user: current_user}} = socket) do
    event =
      Repo.get!(Event, id)
      |> Repo.preload(polls: [:options])

    user_votes =
      Repo.all(
        from v in Acorte.Polls.Vote,
          where: v.user_id == ^current_user.id,
          select: %{poll_option_id: v.poll_option_id, is_favorite: v.is_favorite}
      )

    my_votes =
      Enum.map(user_votes, fn vote ->
        %{id: vote.poll_option_id, is_favorite: vote.is_favorite}
      end)

    other_user_votes =
      Repo.all(
        from v in Acorte.Polls.Vote,
          join: u in assoc(v, :user),
          where: v.user_id != ^current_user.id,
          select: %{poll_option_id: v.poll_option_id, user_name: u.name}
      )

    other_votes_by_option =
      other_user_votes
      |> Enum.group_by(& &1.poll_option_id, & &1.user_name)

    if connected?(socket) do
      subscribe(event)
    end

    {:noreply,
     assign(socket,
       page_title: page_title(socket.assigns.live_action),
       event: event,
       my_votes: my_votes,
       other_votes_by_option: other_votes_by_option
     )}
  end

  def handle_event(
        "toggle_vote",
        %{"option_id" => option_id},
        %{assigns: %{my_votes: my_votes, current_user: current_user, event: event}} = socket
      ) do
    option_id = String.to_integer(option_id)

    updated_votes =
      case Enum.find(my_votes, &(&1.id == option_id)) do
        %{id: ^option_id} ->
          from(v in Acorte.Polls.Vote,
            where: v.user_id == ^current_user.id and v.poll_option_id == ^option_id
          )
          |> Repo.delete_all()

          Enum.reject(my_votes, &(&1.id == option_id))

        nil ->
          %Acorte.Polls.Vote{
            user_id: current_user.id,
            poll_option_id: option_id
          }
          |> Repo.insert!()

          [%{id: option_id, is_favorite: false} | my_votes]
      end

    broadcast(event, {:vote_updated, current_user.id, updated_votes})
    {:noreply, assign(socket, my_votes: updated_votes)}
  end

  def handle_event(
        "toggle_favorite",
        %{"option_id" => option_id},
        %{assigns: %{current_user: current_user, event: event}} = socket
      ) do
    option_id = String.to_integer(option_id)

    updated_votes =
      case Repo.get_by(Acorte.Polls.Vote,
             user_id: socket.assigns.current_user.id,
             poll_option_id: option_id
           ) do
        nil -> create_vote(option_id, socket)
        vote -> toggle_favorite(vote, socket)
      end

    broadcast(event, {:vote_updated, current_user.id, updated_votes})
    {:noreply, assign(socket, my_votes: updated_votes)}
  end

  defp create_vote(option_id, %{assigns: %{current_user: current_user, my_votes: my_votes}}) do
    %Acorte.Polls.Vote{
      user_id: current_user.id,
      poll_option_id: option_id,
      is_favorite: true
    }
    |> Repo.insert!()

    [%{id: option_id, is_favorite: true} | my_votes]
  end

  defp toggle_favorite(vote, %{assigns: %{my_votes: my_votes}}) do
    vote
    |> Ecto.Changeset.change(is_favorite: not vote.is_favorite)
    |> Repo.update!()

    Enum.map(my_votes, fn v ->
      if v.id == vote.poll_option_id do
        %{v | is_favorite: not v.is_favorite}
      else
        v
      end
    end)
  end

  defp page_title(:show), do: "Show Event"
  defp page_title(:edit), do: "Edit Event"
end
