defmodule PyrexWeb.PrivacyPolicyController do
  @moduledoc false

  use PyrexWeb, :controller

  def index(conn, _), do: render(conn, :index)
end
