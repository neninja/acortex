defmodule Acorte.Polls.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  schema "votes" do
    field :is_favorite, :boolean
    belongs_to :poll_option, Acorte.Polls.PollOption

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:is_favorite, :poll_option_id])
    |> validate_required([:poll_option_id])
  end
end
