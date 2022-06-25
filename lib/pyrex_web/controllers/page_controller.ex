defmodule PYRExWeb.PageController do
  use PYRExWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
