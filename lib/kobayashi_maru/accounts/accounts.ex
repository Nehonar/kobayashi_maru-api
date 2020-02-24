defmodule KobayashiMaru.Accounts do
  @moduledoc """
  Accounts context that holds all the logic for accounts.
  """
  import Ecto.Query, warn: false
  alias KobayashiMaru.Repo

  alias KobayashiMaru.Accounts.User
  alias KobayashiMaru.Accounts.GuestUser

  @spec list_users :: any
  def list_users do
    Repo.all(User)
  end

  @spec list_guest_users :: any
  def list_guest_users do
    Repo.all(GuestUser)
  end

  @spec get_user(any) :: any
  def get_user(id), do: Repo.get!(User, id)

  @spec get_guest_user(any) :: any
  def get_guest_user(id), do: Repo.get!(GuestUser, id)

  @spec create_user(:invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def create_user(attrs \\ %{}) do
    IO.inspect(attrs)
    result =
      %User{}
      |> User.registration_changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, user} -> {:ok, %User{user | password: nil}}
      _ -> result
    end
  end

  @spec create_guest_user(
          :invalid
          | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def create_guest_user(attrs \\ %{}) do
    %GuestUser{}
    |> GuestUser.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect(label: "REPOS INSERT")
  end

  @spec update_user(
          KobayashiMaru.Accounts.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @spec update_guest_user(
          KobayashiMaru.Accounts.GuestUser.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def update_guest_user(%GuestUser{} = guest_user, attrs) do
    guest_user
    |> GuestUser.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_user(KobayashiMaru.Accounts.User.t()) :: any
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def delete_guest_user(%GuestUser{} = guest_user) do
    Repo.delete(guest_user)
  end

  @spec change_user(KobayashiMaru.Accounts.User.t()) :: Ecto.Changeset.t()
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  @spec change_guest_user(KobayashiMaru.Accounts.GuestUser.t()) :: Ecto.Changeset.t()
  def change_guest_user(%GuestUser{} = guest_user) do
    GuestUser.changeset(guest_user, %{})
  end

  @spec authenticate(binary, any) :: :error | {:ok, atom | %{password_hash: <<_::64, _::_*8>>}}
  def authenticate(email, password) do
    user = Repo.get_by(User, email: String.downcase(email))

    case check_password(user, password) do
      true -> {:ok, user}
      _ -> :error
    end
  end

  defp check_password(user, password) do
    case user do
      nil -> Comeonin.Argon2.dummy_checkpw()
      _ -> Comeonin.Argon2.checkpw(password, user.password_hash)
    end
  end
end
