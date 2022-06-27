defmodule PYRExWeb.Router do
  use PYRExWeb, :router

  import Phoenix.LiveDashboard.Router

  defp basic_auth(conn, _) do
    credentials = PYREx.config([:basic_auth])
    Plug.BasicAuth.basic_auth(conn, credentials)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PYRExWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through [:browser, :basic_auth]

    live_dashboard "/dashboard", metrics: PYRExWeb.Telemetry
  end

  scope "/", PYRExWeb do
    pipe_through :browser

    live "/", AppLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", PYRExWeb do
  #   pipe_through :api
  # end
end
