defmodule PYRExWeb.Components.App do
  @moduledoc """
  Application UI components.
  """

  use PYRExWeb, :component

  def layout(assigns) do
    ~H"""
    <div x-data="{ menuOpen: false }">
      <!-- Off-canvas menu for mobile, show/hide based on off-canvas menu state. -->
      <div class="relative z-40 md:hidden" role="dialog" aria-modal="true" x-show="menuOpen">
        <!-- Off-canvas menu backdrop, show/hide based on off-canvas menu state. -->
        <div
          x-show="menuOpen"
          x-transition:enter="transition-opacity ease-linear duration-300"
          x-transition:enter-start="opacity-0"
          x-transition:enter-end="opacity-100"
          x-transition:leave="transition-opacity ease-linear duration-300"
          x-transition:leave-start="opacity-100"
          x-transition:leave-end="opacity-0"
          class="fixed inset-0 bg-gray-600 bg-opacity-75"
        >
        </div>

        <div class="fixed inset-0 flex z-40">
          <!-- Off-canvas menu, show/hide based on off-canvas menu state. -->
          <div
            x-show="menuOpen"
            x-transition:enter="transition ease-in-out duration-300 transform"
            x-transition:enter-start="-translate-x-full"
            x-transition:enter-end="translate-x-0"
            x-transition:leave="transition ease-in-out duration-300 transform"
            x-transition:leave-start="translate-x-0"
            x-transition:leave-end="-translate-x-full"
            class="relative flex-1 flex flex-col max-w-xs w-full bg-gray-800"
          >
            <!-- Close button, show/hide based on off-canvas menu state. -->
            <div
              x-show="menuOpen"
              x-transition:enter="ease-in-out duration-300"
              x-transition:enter-start="opacity-0"
              x-transition:enter-end="opacity-100"
              x-transition:leave="ease-in-out duration-300"
              x-transition:leave-start="opacity-100"
              x-transition:leave-end="opacity-0"
              class="absolute top-0 right-0 -mr-12 pt-2"
            >
              <button
                type="button"
                class="ml-1 flex items-center justify-center h-10 w-10 rounded-full focus:outline-none focus:ring-2 focus:ring-inset focus:ring-white"
                @click="menuOpen = ! menuOpen"
              >
                <span class="sr-only">Close sidebar</span>
                <!-- Heroicon name: outline/x -->
                <Components.Icons.outline_x class="h-6 w-6 text-white" aria-hidden="true" />
              </button>
            </div>

            <div class="flex-1 h-0 pt-5 pb-4 overflow-y-auto">
              <.nav type="mobile" {assigns} />
            </div>
            <.copyright />
          </div>

          <div class="flex-shrink-0 w-14">
            <!-- Force sidebar to shrink to fit close icon -->
          </div>
        </div>
      </div>
      <!-- Static sidebar for desktop -->
      <div class="hidden md:flex md:w-64 md:flex-col md:fixed md:inset-y-0">
        <!-- Sidebar component, swap this element with another sidebar if you like -->
        <div class="flex-1 flex flex-col min-h-0 bg-gray-800">
          <div class="flex-1 flex flex-col pt-5 pb-4 overflow-y-auto">
            <.nav type="desktop" {assigns} />
          </div>
          <.copyright />
        </div>
      </div>
      <div class="md:pl-64 flex flex-col flex-1">
        <div class="sticky top-0 z-10 md:hidden pl-1 pt-1 sm:pl-3 sm:pt-3 bg-gray-100">
          <button
            type="button"
            class="-ml-0.5 -mt-0.5 h-12 w-12 inline-flex items-center justify-center rounded-md text-gray-500 hover:text-gray-900 focus:outline-none focus:ring-2 focus:ring-inset focus:ring-indigo-500"
            @click="menuOpen = ! menuOpen"
          >
            <span class="sr-only">Open sidebar</span>
            <!-- Heroicon name: outline/menu -->
            <Components.Icons.outline_menu />
          </button>
        </div>
        <main class="flex-1">
          <div class="py-6">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 md:px-8">
              <div class="block md:hidden"><.logo text_color="black" /></div>
              <!-- Replace with your content -->
              <div class="py-4">
                <div class="border-4 border-line border-transparent rounded-lg h-96">
                  <%= render_slot(@inner_block) %>
                </div>
              </div>
              <!-- /End replace -->
            </div>
          </div>
        </main>
      </div>
    </div>
    """
  end

  def logo(assigns) do
    assigns = assign_new(assigns, :text_color, fn -> "white" end)

    ~H"""
    <h2 class={"text-3xl text-#{@text_color} font-bold"}>Phone Your Rep</h2>
    """
  end

  def copyright(assigns) do
    ~H"""
    <div class="flex-shrink-0 flex bg-gray-700 p-4">
      <div class="flex items-center">
        <div class="ml-3">
          <p class="text-sm font-medium text-white">© 2022 Matthew Simon Borg</p>
          <a
            href="https://github.com/msimonborg/pyrex/blob/main/LICENSE"
            class="text-xs font-medium text-gray-300 group-hover:text-gray-200"
          >
            Apache License 2.0
          </a>
        </div>
      </div>
    </div>
    """
  end

  def nav(assigns) do
    ~H"""
    <a href="/" class="flex flex-shrink-0 items-center px-4">
      <.logo />
    </a>
    <nav class="mt-5 flex-1 px-2 space-y-1">
      <a
        href="https://github.com/msimonborg/pyrex"
        target="_blank"
        class="text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md"
      >
        <Components.Icons.outline_code class="text-gray-400 group-hover:text-gray-300 mr-4 flex-shrink-0 h-6 w-6" />
        Open Source
      </a>

      <a
        href="https://www.progcode.org/"
        target="_blank"
        class="text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md"
      >
        <Components.Icons.outline_scale class="text-gray-400 group-hover:text-gray-300 mr-4 flex-shrink-0 h-6 w-6" />
        Progressive Coders Network
      </a>

      <a
        href="https://www.patreon.com/msimonborg"
        target="_blank"
        class="text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md"
      >
        <Components.Icons.outline_credit_card class="text-gray-400 group-hover:text-gray-300 mr-4 flex-shrink-0 h-6 w-6" />
        Support
      </a>
      <a
        href={Routes.privacy_policy_path(@conn, :index)}
        class="text-gray-300 hover:bg-gray-700 hover:text-white group flex items-center px-2 py-2 text-base font-medium rounded-md"
      >
        <Components.Icons.outline_eye_off class="text-gray-400 group-hover:text-gray-300 mr-4 flex-shrink-0 h-6 w-6" />
        Privacy Policy
      </a>
    </nav>
    """
  end

  def modal(assigns) do
    ~H"""
    <!-- This example requires Tailwind CSS v2.0+ -->
    <div
      x-show="modalOpen"
      class="relative z-10"
      aria-labelledby={@id}
      :aria-hidden="!modalOpen"
      role="dialog"
      aria-modal="true"
    >
      <!-- Background backdrop, show/hide based on modal state. -->
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
          <!-- Modal panel, show/hide based on modal state. -->
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
                <Components.Icons.outline_x class="h-6 w-6" :aria-hidden="!modalOpen" />
              </button>
            </div>
            <div id={@id}>
              <%= render_slot(@inner_block) %>
            </div>
          </div>
        </div>
      </div>
    </div>
    """
  end
end
