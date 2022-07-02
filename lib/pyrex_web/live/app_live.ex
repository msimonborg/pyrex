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

      <button type="button" id="autocomplete-toggle">toggle</button>

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

  def handle_event("search", %{"search" => %{"lat" => lat, "lon" => lon}}, socket)
      when byte_size(lat) > 0 and byte_size(lon) > 0 do
    Logger.info("coordinates provided by Google Places API")

    coordinates = %{lat: lat, lon: lon}
    {:noreply, fetch_people_with_coordinates(socket, coordinates)}
  end

  def handle_event("search", %{"search" => %{"address" => ""}}, socket) do
    {:noreply,
     socket
     |> put_flash(:error, "please enter an address")
     |> redirect(to: "/")}
  end

  def handle_event("search", %{"search" => %{"address" => address}}, socket) do
    Logger.info("fetching coordinates from #{Geocodex.provider()}")

    case Geocodex.coordinates(address) do
      {:ok, coordinates} ->
        {:noreply, fetch_people_with_coordinates(socket, coordinates)}

      {:error, reason} ->
        Logger.error("error retrieving coordinates with reason #{inspect(reason)}")

        {:noreply,
         socket
         |> put_flash(:error, reason)
         |> redirect(to: "/")}
    end
  end

  defp fetch_people_with_coordinates(socket, %{lat: _, lon: _} = coordinates) do
    Logger.info("received coordinates: #{inspect(coordinates)}")
    people = PYREx.Officials.list_current_people_for_location(coordinates)
    assign(socket, :people, people)
  end
end
