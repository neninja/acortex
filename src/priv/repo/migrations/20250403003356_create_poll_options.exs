defmodule Acorte.Repo.Migrations.CreatePollOptions do
  use Ecto.Migration

  def change do
    create table(:poll_options) do
      add :title, :string
      add :description, :string
      add :poll_id, references(:polls, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:poll_options, [:poll_id])
  end
end
