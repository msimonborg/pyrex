defmodule PyrexWeb.Router do
  use PyrexWeb, :router

  import Phoenix.LiveDashboard.Router

  defp basic_auth(conn, _) do
    credentials = Pyrex.config([:basic_auth])
    Plug.BasicAuth.basic_auth(conn, credentials)
  end

  defp redirect_from_fly_host(conn, :prod) do
    host = Pyrex.config([PyrexWeb.Endpoint, :url, :host])

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
    plug :put_root_layout, {PyrexWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :redirect_from_fly_host, Pyrex.config([:env])
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through [:browser, :basic_auth]

    live_dashboard "/dashboard", metrics: PyrexWeb.Telemetry
  end

  scope "/", PyrexWeb do
    pipe_through :browser

    live "/", AppLive

    get "/privacy-policy", PrivacyPolicyController, :index
    get "/v-cards/district-offices/:office_id", VCardsController, :district_offices
    get "/v-cards/current-terms/:person_id", VCardsController, :current_terms
  end

  # Other scopes may use custom stacks.
  # scope "/api", PyrexWeb do
  #   pipe_through :api
  # end
end
