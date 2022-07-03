defmodule PYRExWeb.Components.Form do
  @moduledoc """
  Form components.
  """

  use PYRExWeb, :component

  def input(%{type: "address"} = assigns) do
    ~H"""
    <div id="search-form" phx-update="ignore">
      <%= label(@form, :address, "Enter your location",
        class: "block text-lg md:text-base font-medium text-gray-700",
        id: "address-input-label"
      ) %>
      <div class="mt-1 relative rounded-md shadow-sm">
        <%= text_input(@form, :address,
          class:
            "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 text-lg md:text-base block w-full border-gray-300 rounded-md",
          placeholder: "725 5th Ave, New York, NY 10022",
          aria_labeledby: "address-input-label",
          id: "address-input"
        ) %>
        <%= hidden_input(@form, :lat, id: "lat-input") %>
        <%= hidden_input(@form, :lon, id: "lon-input") %>
      </div>
    </div>
    """
  end

  def button(%{type: "submit"} = assigns) do
    ~H"""
    <%= submit class: "inline-flex items-center px-8 py-2 border border-transparent shadow-sm text-lg font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end

  def button(%{type: "clear"} = assigns) do
    assigns = assign(assigns, :extra, assigns_to_attributes(assigns, [:inner_block]))

    ~H"""
    <button
      type="button"
      class="inline-flex items-center px-8 py-2 border border-gray-400 shadow-sm text-lg font-medium rounded-md text-gray-600 bg-transparent hover:bg-gray-200 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-200"
      {@extra}
    >
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def toggle(assigns) do
    ~H"""
    <div x-cloak x-data="{ enabled: true }" class="mt-2 flex items-center">
      <button
        type="button"
        id={@id}
        @click="enabled = ! enabled"
        class="flex-shrink-0 group relative rounded-full inline-flex items-center justify-center h-5 w-10 cursor-pointer focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
        role="switch"
        :aria-checked="enabled"
        aria-labelledby={"#{@id}-label"}
      >
        <span aria-hidden="true" class="pointer-events-none absolute w-full h-full rounded-md"></span>
        <span
          aria-hidden="true"
          class="pointer-events-none absolute h-4 w-9 mx-auto rounded-full transition-colors ease-in-out duration-200"
          :class="enabled ? 'bg-indigo-600' : 'bg-gray-200'"
        >
        </span>
        <span
          aria-hidden="true"
          class="pointer-events-none absolute left-0 inline-block h-5 w-5 border border-gray-200 rounded-full bg-white shadow transform ring-0 transition-transform ease-in-out duration-200"
          :class="enabled ? 'translate-x-5' : 'translate-x-0'"
        >
        </span>
      </button>
      <%= if assigns[:inner_block] do %>
        <span class="ml-3" id={"#{@id}-label"}>
          <span class="text-base md:text-sm font-medium text-gray-500">
            <%= render_slot(@inner_block) %>
          </span>
        </span>
      <% end %>
    </div>
    """
  end
end
