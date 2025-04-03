defmodule AcorteWeb.OccasionController do
  use AcorteWeb, :controller

  alias Acorte.Occasions
  alias Acorte.Occasions.Occasion

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
    occasion = Occasions.get_occasion!(id)
    render(conn, :show, occasion: occasion)
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
