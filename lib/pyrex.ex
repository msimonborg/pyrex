defmodule Pyrex do
  @moduledoc """
  Pyrex keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc """
  Looks up `Application` config or raises if keyspace is not configured.
  Copied from LiveBeats github.com/fly-apps/live_beats/blob/master/lib/live_beats.ex
  ## Examples
      config :pyrex, :basic_auth,
        username: "username",
        password: "password"
      iex> Pyrex.config([:basic_auth])
      [username: "username", password: "password"]
      iex> Pyrex.config([:basic_auth, :username])
      "username"
      iex> Pyrex.config([:basic_auth, :password])
      "password"
  """
  def config([main_key | rest] = keyspace) when is_list(keyspace) do
    main = Application.fetch_env!(:pyrex, main_key)

    Enum.reduce(rest, main, fn next_key, current ->
      case Keyword.fetch(current, next_key) do
        {:ok, val} -> val
        :error -> raise ArgumentError, "no config found under #{inspect(keyspace)}"
      end
    end)
  end
end
