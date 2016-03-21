defmodule Standup.Repo.Migrations.CreateItem do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :name, :string
      add :standup_id, references(:standups, on_delete: :nothing)

      timestamps
    end
    create index(:items, [:standup_id])

  end
end
