defmodule KobayashiMaru.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @spec start(any, any) :: {:error, any} | {:ok, pid}
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(KobayashiMaru.Repo, []),
      # Start the endpoint when the application starts
      supervisor(KobayashiMaruWeb.Endpoint, [])
      # Start your own worker by calling: KobayashiMaru.Worker.start_link(arg1, arg2, arg3)
      # worker(KobayashiMaru.Worker, [arg1, arg2, arg3]),
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: KobayashiMaru.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @spec config_change(any, any, any) :: :ok
  def config_change(changed, _new, removed) do
    KobayashiMaruWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
