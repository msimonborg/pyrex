defmodule PYRExWeb.AppLive do
  @moduledoc """
  The main app view.
  """

  use PYRExWeb, :live_view

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <Components.App.layout>
      <.form let={f} for={:search} phx-submit="search">
        <Components.Form.input form={f} type="address" />
        <div class="m-6" />
        <Components.Form.button type="submit">
          Search <Components.Icons.solid_search class="ml-3 -mr-1 h-5 w-5" />
        </Components.Form.button>
      </.form>

      <ul role="list" class="mt-8 grid grid-cols-1 gap-6 lg:grid-cols-2 xl:grid-cols-3">
        <%= for person <- @people do %>
          <Components.Lists.contact_card person={person} district_office={false} />
          <%= for office <- person.district_offices do %>
            <Components.Lists.contact_card person={person} district_office={office} />
          <% end %>
        <% end %>
      </ul>
    </Components.App.layout>
    """
  end

  @impl true
  def mount(_, _, socket) do
    {:ok, assign_new(socket, :people, fn -> [] end)}
  end

  @impl true
  def handle_event("search", %{"search" => %{"address" => ""}}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "please enter an address")
     |> redirect(to: "/")}
  end

  def handle_event("search", %{"search" => search_params}, socket) do
    case Geocodex.coordinates(search_params["address"]) do
      {:ok, coordinates} ->
        Logger.info("received coordinates: #{inspect(coordinates)}")
        people = PYREx.Officials.list_current_people_for_location(coordinates)
        {:noreply, assign(socket, :people, people)}

      {:error, reason} ->
        Logger.error("error retrieving coordinates with reason #{inspect(reason)}")

        {:noreply,
         socket
         |> put_flash(:error, reason)
         |> redirect(to: "/")}
    end
  end
end
