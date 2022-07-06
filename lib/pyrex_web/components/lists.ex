defmodule PyrexWeb.Components.Lists do
  @moduledoc """
  List components
  """

  use PyrexWeb, :component

  def contact_card(assigns) do
    %{person: person, district_office: district_office} = assigns
    current_term = person.current_term

    assigns =
      assigns
      |> assign_short_name(district_office)
      |> assign_badge(current_term)
      |> assign_hours(district_office)
      |> assign_address(district_office, current_term)
      |> assign_phone(district_office, current_term)
      |> assign_role(current_term)
      |> assign_v_card_path(person, district_office)
      |> assign(:photo_url, Pyrex.Officials.person_photo_url(assigns.person))

    ~H"""
    <li
      x-data="{ show: false, modalOpen: false }"
      x-init="setTimeout(function(){console.log(show = ! show);}, 50)"
      x-show="show"
      x-transition:enter="transition ease-out duration-300"
      x-transition:enter-start="opacity-0 scale-90"
      x-transition:enter-end="opacity-100 scale-100"
      x-transition:leave="transition ease-in duration-300"
      x-transition:leave-start="opacity-100 scale-100"
      x-transition:leave-end="opacity-0 scale-90"
      class="col-span-1 bg-white rounded-lg shadow divide-y divide-gray-200"
    >
      <div class="w-full flex items-center justify-between p-6 space-x-6">
        <div class="flex-1 truncate">
          <div class="flex items-center space-x-3">
            <h3 class="text-gray-900 text-lg md:text-base font-medium truncate">
              <%= @person.official_full %>
            </h3>
            <span class={
              "inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-#{@badge_color}-100 text-#{@badge_color}-800"
            }>
              <%= @badge %>
            </span>
          </div>

          <div class="h-12">
            <p class="mt-1 text-gray-500 text-base md:text-sm whitespace-normal">
              <%= @short_name %>
            </p>
            <button
              type="button"
              @click="modalOpen = ! modalOpen"
              class="mt-1 text-indigo-500 text-base md:text-sm"
            >
              View office details
            </button>
          </div>
        </div>
        <img class="w-11 h-13 bg-gray-300 rounded-md" src={@photo_url} alt="" />
      </div>
      <div>
        <div class="-mt-px flex divide-x divide-gray-200">
          <div class="w-0 flex-1 flex">
            <a
              href={@v_card_path}
              class="relative -mr-px w-0 flex-1 inline-flex items-center justify-center py-4 text-lg md:text-base text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500"
            >
              <Components.Icons.solid_download class="h-5 w-5 text-gray-400" />
              <span class="ml-3">Download</span>
            </a>
          </div>
          <div class="-ml-px w-0 flex-1 flex">
            <a
              href={"tel:+1-#{@phone}"}
              class="relative w-0 flex-1 inline-flex items-center justify-center py-4 text-lg md:text-base text-gray-700 font-medium border border-transparent rounded-br-lg hover:text-gray-500"
            >
              <Components.Icons.solid_phone class="h-5 w-5 text-gray-400" />

              <span class="ml-3">Call</span>
            </a>
          </div>
        </div>
      </div>
      <Components.App.modal id={Base.encode16(:crypto.strong_rand_bytes(8)) <> "-office-modal"}>
        <div>
          <div class="mt-3 text-center sm:mt-5">
            <h3 class="text-xl md:text-lg leading-6 font-medium text-gray-900">
              <%= @person.official_full %>
            </h3>
            <p class="text-base md:text-sm text-gray-500 whitespace-normal">
              <%= @person.current_term.party %>
            </p>
            <p class="text-base md:text-sm text-gray-500 whitespace-normal">
              <%= @role %>
            </p>
            <a
              class="text-base md:text-sm text-indigo-500 hover:text-indigo-700 whitespace-normal"
              target="_blank"
              href={@person.current_term.url}
            >
              <%= @person.current_term.url %>
            </a>
            <div class="mt-2">
              <p class="text-base md:text-sm text-gray-500 whitespace-normal">
                <%= @address %>
              </p>
            </div>
            <%= if @hours do %>
              <div class="mt-2">
                <p class="text-base md:text-sm text-gray-500 whitespace-normal">
                  Hours: <%= @hours %>
                </p>
              </div>
            <% end %>
          </div>
        </div>
        <div class="mt-5 sm:mt-6">
          <a href={"tel:+1-#{@phone}"}>
            <button
              type="button"
              class="inline-flex justify-center w-full rounded-md border border-transparent shadow-sm px-4 py-2 bg-indigo-600 text-lg md:text-base font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 sm:text-sm"
            >
              Call <%= @phone %>
            </button>
          </a>
        </div>
      </Components.App.modal>
    </li>
    """
  end

  defp assign_short_name(assigns, district_office) do
    short_name = if district_office, do: district_office.city <> " office", else: "D.C. office"
    assign(assigns, :short_name, short_name)
  end

  defp assign_badge(assigns, current_term) do
    badge = if current_term.type == "sen", do: "senate", else: "house"

    badge_color =
      case current_term.party do
        "Republican" -> "red"
        "Democrat" -> "blue"
        _ -> "yellow"
      end

    assign(assigns, badge: badge, badge_color: badge_color)
  end

  defp assign_hours(assigns, district_office) do
    hours = if district_office, do: district_office.hours
    assign(assigns, :hours, hours)
  end

  defp assign_address(assigns, district_office, current_term) do
    address =
      if district_office do
        district_office.address
        |> maybe_add_building_and_suite(district_office)
        |> add_city_state_and_zip(district_office)
      else
        current_term.address
      end

    assign(assigns, :address, address)
  end

  defp maybe_add_building_and_suite(address, district_office) do
    %{building: building, suite: suite} = district_office

    if building || suite do
      address <> ",\n" <> "#{if building, do: building <> ", "}" <> "#{if suite, do: suite},"
    else
      address
    end
  end

  defp add_city_state_and_zip(address, district_office) do
    "#{address}\n#{district_office.city}, #{district_office.state} #{district_office.zip}"
  end

  defp assign_phone(socket, district_office, current_term) do
    phone =
      if district_office do
        district_office.phone
      else
        current_term.phone
      end

    assign(socket, :phone, phone)
  end

  defp assign_role(assigns, current_term) do
    role =
      if current_term.type == "sen" do
        "U.S. Senator from #{current_term.state}"
      else
        "U.S. Representative from district #{current_term.state}-#{current_term.district}"
      end

    assign(assigns, :role, role)
  end

  defp assign_v_card_path(assigns, person, district_office) do
    path =
      if district_office do
        Routes.v_cards_path(assigns.socket, :district_offices, district_office)
      else
        Routes.v_cards_path(assigns.socket, :current_terms, person)
      end

    assign(assigns, :v_card_path, path)
  end
end
