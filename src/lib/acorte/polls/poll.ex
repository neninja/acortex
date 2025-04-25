defmodule Acorte.Polls.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  schema "polls" do
    field :description, :string
    field :title, :string
    belongs_to :event, Acorte.Events.Event
    has_many :options, Acorte.Polls.PollOption

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:title, :description, :event_id])
    |> validate_required([:title, :description, :event_id])
  end
end
