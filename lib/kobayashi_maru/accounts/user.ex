defmodule KobayashiMaru.Accounts.User do
  @moduledoc """
  I have added a password virtual field, to temporarily hold the clear-text password.
  This will never be saved to the DB. I also added two changesets,
  one for changing the password and one for the other fields.
  The put_password_hash() function uses the comeonin library
  to get a hash of the password and put that on the password_hash field
  that will be stored in DB.
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias KobayashiMaru.Accounts.User

  schema "users" do
    field(:email, :string)
    field(:name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)

    timestamps()
  end

  @spec changeset(
          KobayashiMaru.Accounts.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email])
    |> validate_required([:name, :email])
    |> validate_length(:name, min: 2, max: 255)
    |> validate_length(:email, min: 5, max: 255)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
  end

  @spec registration_changeset(
          KobayashiMaru.Accounts.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def registration_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> validate_length(:password, min: 8, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Comeonin.Argon2.hashpwsalt(password))

      _ ->
        changeset
    end
  end
end
