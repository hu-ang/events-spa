defmodule Events.Repo.Migrations.CreateInvites do
  use Ecto.Migration

  def change do
    create table(:invites) do
      add :email, :string, null: false
      add :response, :string, null: false, default: "maybe"
      add :happening_id, references(:happenings, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:invites, [:email, :happening_id], unique: true)
    create index(:invites, [:happening_id])
  end
end
