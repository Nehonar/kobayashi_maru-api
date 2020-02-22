defmodule KobayashiMaruWeb.SessionView do
  @moduledoc """
  This is similar although a bit more complex.
  The show.json view renders the user and the token to the client.
  """

  use KobayashiMaruWeb, :view

  def render("show.json", %{user: user, jwt: jwt}) do
    %{
      data: render_one(user, KobayashiMaruWeb.UserView, "user.json"),
      meta: %{token: jwt}
    }
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("erro.json", %{error: error}) do
    %{errors: %{error: error}}
  end
end
