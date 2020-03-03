defmodule KobayashiMaruWeb.ProductController do
  use KobayashiMaruWeb, :controller

  alias KobayashiMaru.Accounts
  alias KobayashiMaru.Auth.Guardian
  alias KobayashiMaruWeb.UserController

  action_fallback(KobayashiMaruWeb.FallbackController)

  def init(conn, %{email: _email, name: _name}), do: IO.puts("Ahora")

  @spec init(any, :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}) ::
          any
  def init(conn, params) do
    IO.inspect(params, label: "::::::::: PARAMS ::::::::")

    case authenticate(params) do
      {:ok, user} ->
        new_conn = Guardian.Plug.sign_in(conn, user)
        jwt = Guardian.Plug.current_token(new_conn)

        new_conn
        |> put_status(:created)
        |> render("show.json", user: user, jwt: jwt)

      :error ->
        UserController.create(conn, create_guest_user())
    end
  end

  defp create_guest_user() do
    token = create_token()

    %{
      "email" => "#{token}@kobayashiMaru",
      "name" => token,
      "password" => token
    }
  end

  defp create_token() do
    {mega, seg, micro} = :os.timestamp()
    "#{mega}#{seg}#{micro}"
  end

  defp authenticate(%{"email" => email, "password" => password}) do
    Accounts.authenticate(email, password)
  end

  defp authenticate(_), do: :error
end
