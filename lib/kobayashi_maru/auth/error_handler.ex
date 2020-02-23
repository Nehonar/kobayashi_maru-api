defmodule KobayashiMaru.Auth.ErrorHandler do
  @moduledoc """
  The Guardian Pipeline will need a module to handle the error it may found.
  """
  import Plug.Conn

  @spec auth_error(Plug.Conn.t(), {any, any}, any) :: Plug.Conn.t()
  def auth_error(conn, {:invalid_token, _reason}, _opts), do: response(conn, :unauthorized, "Invalid token")
  def auth_error(conn, {:unauthenticated, _reason}, _opts), do: response(conn, :unauthorized, "Not authenticated")
  def auth_error(conn, {:no_resource_found, _reason}, _opts), do: response(conn, :unauthorized, "No resource found")
  def auth_error(conn, {type, _reason}, _opts), do: response(conn, :forbidden, to_string(type))

  defp response(conn, status, message) do
    body = Poison.encode!(%{error: message})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(status, body)
  end
end
