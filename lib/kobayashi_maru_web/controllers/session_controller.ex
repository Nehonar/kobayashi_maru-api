defmodule KobayashiMaruWeb.SessionController do
  @moduledoc """
    Its responsibilities are to create new sessions, delete them and refresh them.
  """
  use KobayashiMaruWeb, :controller

  alias KobayashiMaru.Accounts
  alias KobayashiMaru.Auth.Guardian

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, params) do
    case authenticate(params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)

      :error ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", error: "User or email invalid")
    end
  end

  @spec delete(Plug.Conn.t(), any) :: Plug.Conn.t()
  def delete(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> put_status(:no_content)
    |> render("delete.json")
  end

  @spec refresh(Plug.Conn.t(), any) :: Plug.Conn.t()
  def refresh(conn, _params) do
    user = Guardian.Plug.current_resource(conn)
    jwt = Guardian.Plug.current_token(conn)

    case Guardian.refresh(jwt, ttl: {30, :days}) do
      {:ok, _, {new_jwt, _new_claims}} ->
        conn
        |> put_status(:ok)
        |> render("show.json", user: user, jwt: new_jwt)

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", error: "Not Authenticated")
    end
  end

  defp authenticate(%{"email" => email, "password" => password}) do
    Accounts.authenticate(email, password)
  end
  defp authenticate(_) do
    {mega, sec, mili} = :os.timestamp()
    Accounts.create_guest_user(%{"token" => "#{mega}#{sec}#{mili}"})
    |> IO.inspect(label: "AUTHENTICATE FINISHED")
  end
end
