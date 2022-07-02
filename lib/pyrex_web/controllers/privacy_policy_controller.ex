defmodule PYRExWeb.PrivacyPolicyController do
  @moduledoc false

  use PYRExWeb, :controller

  def index(conn, _), do: render(conn, :index)
end
