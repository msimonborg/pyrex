defmodule PYRExWeb.Router do
  use PYRExWeb, :router

  import Phoenix.LiveDashboard.Router

  defp basic_auth(conn, _) do
    credentials = PYREx.config([:basic_auth])
    Plug.BasicAuth.basic_auth(conn, credentials)
  end

  defp redirect_from_fly_host(conn, :prod) do
    host = PYREx.config([PYRExWeb.Endpoint, :url, :host])

    case conn.host do
      ^host -> conn
      _ -> conn |> redirect(external: "https://" <> host) |> halt()
    end
  end

  defp redirect_from_fly_host(conn, _), do: conn

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PYRExWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :redirect_from_fly_host, PYREx.config([:env])
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
