defmodule Acorte.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      AcorteWeb.Telemetry,
      Acorte.Repo,
      {DNSCluster, query: Application.get_env(:acorte, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Acorte.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Acorte.Finch},
      # Start a worker by calling: Acorte.Worker.start_link(arg)
      # {Acorte.Worker, arg},
      # Start to serve requests, typically the last entry
      AcorteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Acorte.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AcorteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
