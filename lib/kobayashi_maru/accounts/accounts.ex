defmodule KobayashiMaru.Accounts do
  @moduledoc """
  Accounts context that holds all the logic for accounts.
  """
  import Ecto.Query, warn: false
  alias KobayashiMaru.Repo

  alias KobayashiMaru.Accounts.User

  @spec list_users :: any
  def list_users do
    Repo.all(User)
  end

  @spec get_user(any) :: any
  def get_user(id), do: Repo.get!(User, id)

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

  @spec update_user(
          KobayashiMaru.Accounts.User.t(),
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: any
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @spec delete_user(KobayashiMaru.Accounts.User.t()) :: any
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @spec change_user(KobayashiMaru.Accounts.User.t()) :: Ecto.Changeset.t()
  def change_user(%User{} = user) do
    User.changeset(user, %{})
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
