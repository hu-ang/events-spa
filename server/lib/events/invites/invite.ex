defmodule Events.Invites.Invite do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invites" do
    field :response, :string
    belongs_to :happening, Events.Happenings.Happening
    belongs_to :user, Events.Users.User, references: :email, foreign_key: :email, type: :string

    timestamps()
  end

  @doc false
  def changeset(invite, attrs) do
    invite
    |> cast(attrs, [:email, :response])
    |> validate_required([:email, :response])
    |> unique_constraint([:email, :happening_id])
  end
end
