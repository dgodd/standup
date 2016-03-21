defmodule Standup.Repo.Migrations.CreateStandup do
  use Ecto.Migration

  def change do
    create table(:standups) do
      add :name, :string

      timestamps
    end

  end
end
