defmodule KobayashiMaruWeb.Router do
  use KobayashiMaruWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  pipeline :api_auth do
    plug(KobayashiMaru.Auth.Pipeline)
  end

  scope "/api", KobayashiMaruWeb do
    pipe_through(:api)

    post("/sessions", SessionController, :create)
    post("/users", UserController, :create)
    post("/addproductcart", ProductController, :init)
  end

  scope "/api", KobayashiMaruWeb do
    pipe_through([:api, :api_auth])

    delete("/sessions", SessionController, :delete)
    post("/sessions/refresh", SessionController, :refresh)
  end
end
