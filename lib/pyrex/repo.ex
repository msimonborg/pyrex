defmodule PYREx.Repo.Local do
  use Ecto.Repo,
    otp_app: :pyrex,
    adapter: Ecto.Adapters.Postgres

  @env Mix.env()

  # Dynamically configure the database url based on runtime and build
  # environments.
  def init(_type, config) do
    Fly.Postgres.config_repo_url(config, @env)
  end
end

defmodule PYREx.Repo do
  use Fly.Repo, local_repo: PYREx.Repo.Local
end
