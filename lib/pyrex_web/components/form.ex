defmodule PYRExWeb.Components.Form do
  @moduledoc """
  Form components.
  """

  use PYRExWeb, :component

  def input(%{type: "address"} = assigns) do
    ~H"""
    <div id="search-form" phx-update="ignore">
      <%= label(@form, :address, "Enter your location",
        class: "block text-lg md:text-base font-medium text-gray-700"
      ) %>
      <div class="mt-1 relative rounded-md shadow-sm">
        <%= text_input(@form, :address,
          class:
            "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 text-lg md:text-base block w-full border-gray-300 rounded-md",
          placeholder: "725 5th Ave, New York, NY 10022",
          aria_invalid: "true",
          aria_describedby: "address-description",
          id: "address-input"
        ) %>
        <%= hidden_input(@form, :lat, id: "lat-input") %>
        <%= hidden_input(@form, :lon, id: "lon-input") %>
      </div>
      <p class="mt-2 text-base md:text-sm text-gray-500" id="address-description">
        We don't save or sell or even look at your data!
      </p>
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
end
