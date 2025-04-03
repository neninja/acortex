defmodule Acorte.Repo.Migrations.CreatePolls do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :title, :string
      add :description, :string
      add :occasion_id, references(:occasions, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:polls, [:occasion_id])
  end
end
