defmodule KobayashiMaruWeb.Router do
  use KobayashiMaruWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :api_auth do
    plug(Toltec.Auth.Pipeline)
  end

  scope "/api", KobayashiMaruWeb do
    pipe_through(:api)

    post("/sessions", SessionController, :create)
    post("/users", UserController, :create)
  end

  scope "/api", KobayashiMaruWeb do
    pipe_through([:api, :api_auth])

    delete("/sessions", SessionController, :delete)
    post("/sessions/refresh", SessionController, :refresh)
  end
end
