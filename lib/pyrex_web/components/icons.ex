defmodule PYRExWeb.Components.Icons do
  @moduledoc """
  A collection of SVG heroicons.
  Source: heroicons.com
  """

  use PYRExWeb, :component

  @doc """
  Heroicon name: solid/chart-bar
  """
  def solid_chart_bar(assigns) do
    ~H"""
    <.solid {assigns}>
      <path d="M2 11a1 1 0 011-1h2a1 1 0 011 1v5a1 1 0 01-1 1H3a1 1 0 01-1-1v-5zM8 7a1 1 0 011-1h2a1 1 0 011 1v9a1 1 0 01-1 1H9a1 1 0 01-1-1V7zM14 4a1 1 0 011-1h2a1 1 0 011 1v12a1 1 0 01-1 1h-2a1 1 0 01-1-1V4z" />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/search
  """
  def solid_search(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M8 4a4 4 0 100 8 4 4 0 000-8zM2 8a6 6 0 1110.89 3.476l4.817 4.817a1 1 0 01-1.414 1.414l-4.816-4.816A6 6 0 012 8z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/cog
  """
  def solid_cog(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M11.49 3.17c-.38-1.56-2.6-1.56-2.98 0a1.532 1.532 0 01-2.286.948c-1.372-.836-2.942.734-2.106 2.106.54.886.061 2.042-.947 2.287-1.561.379-1.561 2.6 0 2.978a1.532 1.532 0 01.947 2.287c-.836 1.372.734 2.942 2.106 2.106a1.532 1.532 0 012.287.947c.379 1.561 2.6 1.561 2.978 0a1.533 1.533 0 012.287-.947c1.372.836 2.942-.734 2.106-2.106a1.533 1.533 0 01.947-2.287c1.561-.379 1.561-2.6 0-2.978a1.532 1.532 0 01-.947-2.287c.836-1.372-.734-2.942-2.106-2.106a1.532 1.532 0 01-2.287-.947zM10 13a3 3 0 100-6 3 3 0 000 6z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/menu
  """
  def solid_menu(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/question-mark-circle
  """
  def solid_question_mark_circle(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zm-8-3a1 1 0 00-.867.5 1 1 0 11-1.731-1A3 3 0 0113 8a3.001 3.001 0 01-2 2.83V11a1 1 0 11-2 0v-1a1 1 0 011-1 1 1 0 100-2zm0 8a1 1 0 100-2 1 1 0 000 2z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/x
  """
  def solid_x(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/link
  """
  def solid_link(assigns) do
    ~H"""
    <.solid {assigns}>
      <path
        fill-rule="evenodd"
        d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z"
        clip-rule="evenodd"
      />
    </.solid>
    """
  end

  @doc """
  Heroicon name: solid/phone
  """
  def solid_phone(assigns) do
    ~H"""
    <.solid {assigns}>
      <path d="M2 3a1 1 0 011-1h2.153a1 1 0 01.986.836l.74 4.435a1 1 0 01-.54 1.06l-1.548.773a11.037 11.037 0 006.105 6.105l.774-1.548a1 1 0 011.059-.54l4.435.74a1 1 0 01.836.986V17a1 1 0 01-1 1h-2C7.82 18 2 12.18 2 5V3z" />
    </.solid>
    """
  end

  @doc """
  Heroicon name: outline/check-circle
  """
  def outline_check_circle(assigns) do
    ~H"""
    <.outline {assigns}>
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"
      />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/credit-card
  """
  def outline_credit_card(assigns) do
    ~H"""
    <.outline {assigns}>
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M3 10h18M7 15h1m4 0h1m-7 4h12a3 3 0 003-3V8a3 3 0 00-3-3H6a3 3 0 00-3 3v8a3 3 0 003 3z"
      />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/exclamation
  """
  def outline_exclamation(assigns) do
    ~H"""
    <.outline {assigns}>
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"
      />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/x
  """
  def outline_x(assigns) do
    ~H"""
    <.outline {assigns}>
      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18L18 6M6 6l12 12" />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/code
  """
  def outline_code(assigns) do
    ~H"""
    <.outline {assigns}>
      <path stroke-linecap="round" stroke-linejoin="round" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4" />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/scale
  """
  def outline_scale(assigns) do
    ~H"""
    <.outline {assigns}>
      <path
        stroke-linecap="round"
        stroke-linejoin="round"
        d="M3 6l3 1m0 0l-3 9a5.002 5.002 0 006.001 0M6 7l3 9M6 7l6-2m6 2l3-1m-3 1l-3 9a5.002 5.002 0 006.001 0M18 7l3 9m-3-9l-6-2m0-2v2m0 16V5m0 16H9m3 0h3"
      />
    </.outline>
    """
  end

  @doc """
  Heroicon name: outline/menu
  """
  def outline_menu(assigns) do
    ~H"""
    <.outline {assigns}>
      <path stroke-linecap="round" stroke-linejoin="round" d="M4 6h16M4 12h16M4 18h16" />
    </.outline>
    """
  end

  defp solid(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "h-5 w-5" end)
      |> assign(:extras, assigns_to_attributes(assigns, [:class]))

    ~H"""
    <svg
      xmlns="http://www.w3.org/2000/svg"
      class={@class}
      viewBox="0 0 20 20"
      fill="currentColor"
      {@extras}
    >
      <%= render_slot(@inner_block) %>
    </svg>
    """
  end

  defp outline(assigns) do
    assigns =
      assigns
      |> assign_new(:class, fn -> "h-6 w-6" end)
      |> assign(:extras, assigns_to_attributes(assigns, [:class]))

    ~H"""
    <svg
      class={@class}
      xmlns="http://www.w3.org/2000/svg"
      fill="none"
      viewBox="0 0 24 24"
      stroke-width="2"
      stroke="currentColor"
      {@extras}
    >
      <%= render_slot(@inner_block) %>
    </svg>
    """
  end
end
