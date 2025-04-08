defmodule AcorteWeb.OccasionController do
  use AcorteWeb, :controller

  alias Acorte.Occasions
  alias Acorte.Occasions.Occasion

  # Adicione esta linha
  import Ecto.Query, only: [from: 2]

  def index(conn, _params) do
    occasions = Occasions.list_occasions()
    render(conn, :index, occasions: occasions)
  end

  def new(conn, _params) do
    changeset = Occasions.change_occasion(%Occasion{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"occasion" => occasion_params}) do
    case Occasions.create_occasion(occasion_params) do
      {:ok, occasion} ->
        conn
        |> put_flash(:info, "Occasion created successfully.")
        |> redirect(to: ~p"/occasions/#{occasion}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    occasion =
      Acorte.Repo.get!(Occasion, id)
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
      occasion: occasion,
      my_votes: user_votes_ids,
      my_favorite_votes: favorite_votes_ids,
      other_votes_by_option: other_votes_by_option
    )
  end

  def edit(conn, %{"id" => id}) do
    occasion = Occasions.get_occasion!(id)
    changeset = Occasions.change_occasion(occasion)
    render(conn, :edit, occasion: occasion, changeset: changeset)
  end

  def update(conn, %{"id" => id, "occasion" => occasion_params}) do
    occasion = Occasions.get_occasion!(id)

    case Occasions.update_occasion(occasion, occasion_params) do
      {:ok, occasion} ->
        conn
        |> put_flash(:info, "Occasion updated successfully.")
        |> redirect(to: ~p"/occasions/#{occasion}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, occasion: occasion, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    occasion = Occasions.get_occasion!(id)
    {:ok, _occasion} = Occasions.delete_occasion(occasion)

    conn
    |> put_flash(:info, "Occasion deleted successfully.")
    |> redirect(to: ~p"/occasions")
  end
end
