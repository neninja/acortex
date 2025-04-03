defmodule Acorte.Occasions.Occasion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "occasions" do
    field :description, :string
    field :title, :string
    belongs_to :owner, Acorte.Accounts.User
    has_many :polls, Acorte.Polls.Poll

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(occasion, attrs) do
    occasion
    |> cast(attrs, [:title, :description, :owner_id])
    |> validate_required([:title, :description, :owner_id])
  end
end
