defmodule Acorte.Repo.Migrations.CreateVotes do
  use Ecto.Migration

  def change do
    create table(:votes) do
      add :is_favorite, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :nothing)
      add :poll_option_id, references(:poll_options, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:votes, [:poll_option_id])
  end
end
