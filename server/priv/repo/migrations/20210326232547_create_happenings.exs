defmodule Events.Repo.Migrations.CreateHappenings do
  use Ecto.Migration

  def change do
    create table(:happenings) do
      add :name, :text, null: false
      add :date, :naive_datetime, null: false
      add :description, :text, null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:happenings, [:user_id])
  end
end
