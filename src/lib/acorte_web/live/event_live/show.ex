# fluxo liveview
# primeira renderização: mount (conexão com pub sub) -> handle_params
# evento da interface: handle_event -> broadcast -> handle_info (broadcast)

defmodule AcorteWeb.EventLive.Show do
  use AcorteWeb, :live_view

  alias Acorte.Events.Event
  alias Acorte.Repo
  import Ecto.Query, only: [from: 2]

  def mount(%{"id" => id}, _session, socket) do
    current_user = socket.assigns[:current_user]

    if connected?(socket) do
      Phoenix.PubSub.subscribe(Acorte.PubSub, "event:#{id}")
    end

    {:ok,
     assign(socket,
       event_id: id,
       current_user: current_user,
       my_votes: [],
       other_votes_by_option: %{}
     )}
  end

  defp broadcast_vote_updates(event, user, value) do
    Phoenix.PubSub.broadcast(
      Acorte.PubSub,
      "event:#{event.id}",
      {:other_vote_updated, user, value}
    )
  end

  def handle_info({:my_vote_updated, updated_votes}, socket) do
    {:noreply, assign(socket, my_votes: updated_votes)}
  end

  def handle_info({:other_vote_updated, user, updated_votes}, socket) do
    current_user = socket.assigns.current_user

    if user.id == current_user.id do
      {:noreply, socket}
    else
      other_votes_by_option =
        socket.assigns.other_votes_by_option
        |> Enum.reduce(%{}, fn {option_id, users}, acc ->
          if Enum.any?(updated_votes, &(&1.id == option_id)) do
            updated_users =
              if Enum.member?(users, user.name) do
                users
              else
                [user.name | users]
              end

            Map.put(acc, option_id, updated_users)
          else
            updated_users = Enum.reject(users, &(&1 == user.name))
            Map.put(acc, option_id, updated_users)
          end
        end)

      new_votes =
        updated_votes
        |> Enum.reduce(other_votes_by_option, fn %{id: option_id}, acc ->
          if Map.has_key?(acc, option_id) do
            acc
          else
            Map.put(acc, option_id, [user.name])
          end
        end)

      {:noreply, assign(socket, other_votes_by_option: new_votes)}
    end
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

    other_votes_by_option =
      Repo.all(
        from v in Acorte.Polls.Vote,
          join: u in assoc(v, :user),
          where: v.user_id != ^current_user.id,
          select: %{poll_option_id: v.poll_option_id, user_name: u.name}
      )
      |> Enum.group_by(& &1.poll_option_id, & &1.user_name)

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

    broadcast_vote_updates(event, current_user, updated_votes)
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

    broadcast_vote_updates(event, current_user, updated_votes)
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
