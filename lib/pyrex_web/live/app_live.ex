defmodule PyrexWeb.AppLive do
  @moduledoc """
  The main app view.
  """

  use PyrexWeb, :live_view

  require Logger

  @impl true
  def render(assigns) do
    ~H"""
    <.form let={f} for={:search} phx-submit="search">
      <Components.Form.input form={f} type="address" {assigns} />
      <Components.Form.toggle id="autocomplete-toggle">
        <.autocomplete_toggle_label {assigns} />
      </Components.Form.toggle>
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
    """
  end

  defp autocomplete_toggle_label(assigns) do
    ~H"""
    <div x-data="{ modalOpen: false }" class="flex inline-flex space-x-2">
      <span>Toggle off to disable Google address autocomplete</span>
      <button @click="modalOpen = ! modalOpen" type="button">
        <Components.Icons.solid_question_mark_circle />
      </button>
      <Components.App.modal id="toggle-autocomplete-help">
        <div class="p-2 text-base space-y-2">
          <p>
            Toggles the Google Maps address autocomplete on and off.
          </p>
          <p>
            If you do not use autocomplete
            you must manually enter a fully qualified and valid address.
          </p>
          <p>
            See our
            <a
              class="text-indigo-500 hover:text-indigo-700"
              href={Routes.privacy_policy_path(@socket, :index)}
            >
              Privacy Policy
            </a>
            for more information regarding usage of this feature.
          </p>
        </div>
      </Components.App.modal>
    </div>
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
    people = Pyrex.Officials.list_current_people_for_location(coordinates)
    assign(socket, :people, people)
  end
end
