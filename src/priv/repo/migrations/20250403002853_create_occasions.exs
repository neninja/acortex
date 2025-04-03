defmodule Acorte.Repo.Migrations.CreateOccasions do
  use Ecto.Migration

  def change do
    create table(:occasions) do
      add :title, :string
      add :description, :string
      add :owner_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:occasions, [:owner_id])
  end
end
