defmodule KobayashiMaruWeb.UserController do
  use KobayashiMaruWeb, :controller

  alias KobayashiMaru.Accounts
  alias KobayashiMaru.Accounts.User
  alias KobayashiMaru.Auth.Guardian

  action_fallback(KobayashiMaruWeb.FallbackController)

  @spec create(any, :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def create(conn, params) do
    with {:ok, %User{} = user} <- Accounts.create_user(params) do
      new_conn = Guardian.Plug.sign_in(conn, user)
      jwt = Guardian.Plug.current_token(new_conn)

      new_conn
      |> put_status(:created)
      |> render(KobayashiMaruWeb.SessionView, "show.json", user: user, jwt: jwt)
    end
  end
end
