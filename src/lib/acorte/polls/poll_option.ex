defmodule Acorte.Polls.PollOption do
  use Ecto.Schema
  import Ecto.Changeset

  schema "poll_options" do
    field :description, :string
    field :title, :string
    belongs_to :poll, Acorte.Polls.Poll
    has_many :votes, Acorte.Polls.Vote

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(poll_option, attrs) do
    poll_option
    |> cast(attrs, [:title, :description, :poll_id])
    |> validate_required([:title, :description, :poll_id])
  end
end
