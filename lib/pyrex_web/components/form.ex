defmodule PYRExWeb.Components.Form do
  @moduledoc """
  Form components.
  """

  use PYRExWeb, :component

  def input(%{type: "address"} = assigns) do
    ~H"""
    <div>
      <%= label(@form, :address, "Enter your full street address",
        class: "block text-sm font-medium text-gray-700"
      ) %>
      <div class="mt-1 relative rounded-md shadow-sm">
        <%= text_input(@form, :address,
          class:
            "shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md",
          placeholder: "725 5th Ave, New York, NY 10022",
          aria_invalid: "true",
          aria_describedby: "address-description",
          id: "address-input"
        ) %>
      </div>
      <p class="mt-2 text-sm text-gray-500" id="address-description">
        We don't save or sell or even look at your data!
      </p>
    </div>
    """
  end

  def button(%{type: "submit"} = assigns) do
    ~H"""
    <%= submit class: "inline-flex items-center px-4 py-2 border border-transparent shadow-sm text-base font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500" do %>
      <%= render_slot(@inner_block) %>
    <% end %>
    """
  end
end
