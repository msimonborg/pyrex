defmodule Pyrex.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        {Cluster.Supervisor, [topologies(), [name: Pyrex.ClusterSupervisor]]},
        # Start the RPC server before the DB
        {Fly.RPC, []},
        Pyrex.Repo.Local,
        # Start the tracker after the DB
        {Fly.Postgres.LSN.Tracker, repo: Pyrex.Repo.Local},
        PyrexWeb.Telemetry,
        {Phoenix.PubSub, name: Pyrex.PubSub},
        PyrexWeb.Endpoint
      ] ++ add_database_updater_in_primary_region()

    opts = [strategy: :one_for_one, name: Pyrex.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PyrexWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp add_database_updater_in_primary_region do
    if Fly.is_primary?(), do: [Pyrex.DatabaseUpdater], else: []
  end

  # libcluster clustering topologies
  defp topologies do
    Application.get_env(:libcluster, :topologies) || []
  end
end
