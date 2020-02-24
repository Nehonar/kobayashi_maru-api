defmodule KobayashiMaru.Accounts.GuestUser do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "guest_users" do
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(guest_user, attrs) do
    guest_user
    |> cast(attrs, [:token])
    |> validate_required([:token])
    |> unique_constraint(:token)
  end
end
