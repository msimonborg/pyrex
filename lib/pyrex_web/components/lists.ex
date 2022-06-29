defmodule PYRExWeb.Components.Lists do
  @moduledoc """
  List components
  """

  use PYRExWeb, :component

  defp assign_short_name(assigns, district_office) do
    short_name = if district_office, do: district_office.city <> " office", else: "D.C. office"
    assign(assigns, :short_name, short_name)
  end

  defp assign_badge(assigns, current_term) do
    badge = if current_term.type == "sen", do: "senate", else: "house"
    assign(assigns, :badge, badge)
  end

  defp assign_address(assigns, district_office, current_term) do
    address =
      if district_office do
        district_office.address
        |> maybe_add_building_and_suite(district_office)
        |> add_city_state_and_zip(district_office)
        |> maybe_add_hours(district_office.hours)
      else
        current_term.office
      end

    assign(assigns, :address, address)
  end

  defp maybe_add_building_and_suite(address, district_office) do
    %{building: building, suite: suite} = district_office

    if building || suite do
      address <> "\n" <> "#{if building, do: building <> " "}" <> "#{if suite, do: suite}"
    else
      address
    end
  end

  defp maybe_add_hours(address, hours) do
    if hours do
      address <> "\n" <> hours
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

  def contact_card(assigns) do
    %{person: person, district_office: district_office} = assigns
    current_term = person.current_term

    assigns =
      assigns
      |> assign_short_name(district_office)
      |> assign_badge(current_term)
      |> assign_address(district_office, current_term)
      |> assign_phone(district_office, current_term)
      |> assign(
        :photo_url,
        "https://raw.githubusercontent.com/unitedstates/images/gh-pages/congress/225x275/#{assigns.person.id}.jpg"
      )

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
            <span class="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-sm md:text-xs font-medium bg-green-100 rounded-full">
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
              href={current_term.contact_form || current_term.url}
              class="relative -mr-px w-0 flex-1 inline-flex items-center justify-center py-4 text-lg md:text-base text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500"
            >
              <Components.Icons.solid_link class="h-5 w-5 text-gray-400" />
              <span class="ml-3">Contact</span>
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
      <.modal id={Base.encode16(:crypto.strong_rand_bytes(8)) <> "-office-modal"} {assigns} />
    </li>
    """
  end

  def modal(assigns) do
    ~H"""
    <!-- This example requires Tailwind CSS v2.0+ -->
    <div
      x-show="modalOpen"
      class="relative z-10"
      aria-labelledby={@id}
      role="dialog"
      aria-modal="true"
    >
      <!--
    Background backdrop, show/hide based on modal state.


    -->
      <div
        class="fixed inset-0 bg-gray-500 bg-opacity-75 transition-opacity"
        x-show="modalOpen"
        x-transition:enter="ease-out duration-300"
        x-transition:enter-start="opacity-0"
        x-transition:enter-end="opacity-100"
        x-transition:leave="ease-in duration-200"
        x-transition:leave-start="opacity-100"
        x-transition:leave-end="opacity-0"
      >
      </div>

      <div class="fixed z-10 inset-0 overflow-y-auto">
        <div class="flex items-end sm:items-center justify-center min-h-full p-4 text-center sm:p-0">
          <!--
        Modal panel, show/hide based on modal state. -->
          <div
            x-show="modalOpen"
            x-transition:enter="ease-out duration-300"
            x-transition:enter-start="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            x-transition:enter-end="opacity-100 translate-y-0 sm:scale-100"
            x-transition:leave="ease-in duration-300"
            x-transition:leave-start="opacity-100 translate-y-0 sm:scale-100"
            x-transition:leave-end="opacity-0 translate-y-4 sm:translate-y-0 sm:scale-95"
            class="relative bg-white rounded-lg px-4 pt-5 pb-4 text-left overflow-hidden shadow-xl transform transition-all sm:my-8 sm:max-w-sm sm:w-full sm:p-6"
          >
            <div
              x-show="modalOpen"
              x-transition:enter="ease-in-out duration-300"
              x-transition:enter-start="opacity-0"
              x-transition:enter-end="opacity-100"
              x-transition:leave="ease-in-out duration-300"
              x-transition:leave-start="opacity-100"
              x-transition:leave-end="opacity-0"
              class="block absolute top-0 right-0 pt-4 pr-4"
            >
              <button
                type="button"
                class="bg-white rounded-md text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                @click="modalOpen = ! modalOpen"
              >
                <span class="sr-only">Close modal</span>
                <!-- Heroicon name: outline/x -->
                <Components.Icons.outline_x class="h-6 w-6" aria-hidden="true" />
              </button>
            </div>
            <div>
              <div class="mx-auto flex items-center justify-center h-12 w-12 rounded-full bg-green-100">
                <img class="w-11 h-13 bg-gray-300 rounded-md" src={@photo_url} alt="" />
              </div>
              <div class="mt-3 text-center sm:mt-5">
                <h3 class="text-xl md:text-lg leading-6 font-medium text-gray-900" id={@id}>
                  <%= @person.official_full %>
                </h3>
                <div class="mt-2">
                  <p class="text-base md:text-sm text-gray-500 whitespace-normal">
                    <%= @address %>
                  </p>
                </div>
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
          </div>
        </div>
      </div>
    </div>
    """
  end
end
