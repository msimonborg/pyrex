defmodule PYREx.DataUpdater do
  @moduledoc """
  A GenServer that periodically updates the database with fresh
  legislator data.
  """

  use GenServer

  @doc false
  def start_link(_) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    1
    |> :timer.hours()
    |> :timer.send_interval(:maybe_update)

    {:ok, []}
  end

  @impl true
  def handle_info(:maybe_update, state) do
    now = Time.utc_now()
    if now.hour == 8, do: send(self(), :update)
    {:noreply, state}
  end

  def handle_info(:update, state) do
    PYREx.Loader.us_legislators()
    PYREx.Loader.us_legislators_district_offices()
    {:noreply, state}
  end
end
