defmodule KobayashiMaruWeb.Router do
  use KobayashiMaruWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", KobayashiMaruWeb do
    pipe_through(:api)
  end
end
