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

    ~H"""
    <li
      x-data="{ show: false }"
      x-init="setTimeout(function(){console.log(show = ! show);}, 100)"
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
            <h3 class="text-gray-900 text-sm font-medium truncate"><%= @person.official_full %></h3>
            <span class="flex-shrink-0 inline-block px-2 py-0.5 text-green-800 text-xs font-medium bg-green-100 rounded-full">
              <%= @badge %>
            </span>
          </div>

          <div class="h-12">
            <p class="mt-1 text-gray-500 text-sm whitespace-normal">
              <%= @short_name %>
            </p>
            <p class="mt-1 text-gray-500 text-sm whitespace-normal">
              <%= @address %>
            </p>
          </div>
        </div>
        <img
          class="w-11 h-13 bg-gray-300 rounded-md"
          src={
            "https://raw.githubusercontent.com/unitedstates/images/gh-pages/congress/225x275/#{@person.id}.jpg"
          }
          alt=""
        />
      </div>
      <div>
        <div class="-mt-px flex divide-x divide-gray-200">
          <div class="w-0 flex-1 flex">
            <a
              href={current_term.contact_form || current_term.url}
              class="relative -mr-px w-0 flex-1 inline-flex items-center justify-center py-4 text-sm text-gray-700 font-medium border border-transparent rounded-bl-lg hover:text-gray-500"
            >
              <Components.Icons.solid_link class="h-5 w-5 text-gray-400" />
              <span class="ml-3">Contact</span>
            </a>
          </div>
          <div class="-ml-px w-0 flex-1 flex">
            <a
              href={"tel:+1-#{@phone}"}
              class="relative w-0 flex-1 inline-flex items-center justify-center py-4 text-sm text-gray-700 font-medium border border-transparent rounded-br-lg hover:text-gray-500"
            >
              <Components.Icons.solid_phone class="h-5 w-5 text-gray-400" />

              <span class="ml-3">Call</span>
            </a>
          </div>
        </div>
      </div>
    </li>
    """
  end
end
