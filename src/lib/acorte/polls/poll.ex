defmodule Acorte.Polls.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  schema "polls" do
    field :description, :string
    field :title, :string
    belongs_to :occasion, Acorte.Occasions.Occasion
    has_many :options, Acorte.Polls.PollOption

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:title, :description, :occasion_id])
    |> validate_required([:title, :description, :occasion_id])
  end
end
