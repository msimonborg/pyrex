defmodule Pyrex.Repo.Local do
  @moduledoc false

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

defmodule Pyrex.Repo do
  @moduledoc false

  use Fly.Repo, local_repo: Pyrex.Repo.Local
end
