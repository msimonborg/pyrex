defmodule PYREx.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children =
      [
        # Start the RPC server before the DB
        {Fly.RPC, []},
        PYREx.Repo.Local,
        # Start the tracker after the DB
        {Fly.Postgres.LSN.Tracker, repo: PYREx.Repo.Local},
        PYRExWeb.Telemetry,
        {Phoenix.PubSub, name: PYREx.PubSub},
        PYRExWeb.Endpoint
      ] ++ add_data_updater_in_primary_region()

    opts = [strategy: :one_for_one, name: PYREx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PYRExWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp add_data_updater_in_primary_region do
    if Fly.is_primary?(), do: [PYREx.DataUpdater], else: []
  end
end
