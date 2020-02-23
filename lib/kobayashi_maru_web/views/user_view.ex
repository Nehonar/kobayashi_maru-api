defmodule KobayashiMaruWeb.UserView do
  @moduledoc """
    The render method receives a user and returns a map
    with the properties that we want to expos to the clients.
  """
  use KobayashiMaruWeb, :view

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      email: user.email
    }
  end
end
