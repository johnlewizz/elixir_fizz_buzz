defmodule ElixirFizzBuzzWeb.FizzBuzzLive do
  use ElixirFizzBuzzWeb, :live_view
  alias FizzBuzz.FizzBuzzGenerator
  alias FizzBuzz.FavouritesCache

  alias ElixirFizzBuzzWeb.{
    FizzBuzzFormComponent,
    FizzBuzzTableComponent,
    FizzBuzzPaginationComponent
  }

  def mount(_params, _session, socket) do
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_homepage_values()
    page_size = 100

    socket =
      assign(socket,
        fizzbuzz_list: fizzbuzz_list,
        page: 1,
        page_size: page_size,
        start_range: 1,
        end_range: 100,
        total_pages: total_pages(fizzbuzz_list, page_size)
      )

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <head>
      <link rel="stylesheet" type="text/css" href="fizzbuzz.css" />
    </head>
    <div class="container container-style">
      <%= live_component(FizzBuzzFormComponent, Map.put(assigns, :id, "fizz_buzz_form")) %>
      <div class="container container-inner">
        <%= live_component(FizzBuzzTableComponent, Map.put(assigns, :id, "fizz_buzz_table")) %>
      </div>
      <%= live_component(FizzBuzzPaginationComponent, Map.put(assigns, :id, "fizz_buzz_pagination")) %>
    </div>
    """
  end

  def handle_event("prev_page", _params, socket) do
    page = max(socket.assigns.page - 1, 1)
    {:noreply, assign(socket, page: page)}
  end

  def handle_event("next_page", _params, socket) do
    page = min(socket.assigns.page + 1, socket.assigns.total_pages)
    {:noreply, assign(socket, page: page)}
  end

  def handle_event("favourite", %{"key" => key, "result" => value}, socket) do
    int_key = String.to_integer(key)
    FavouritesCache.add_favourite(int_key, value)

    {:ok, fizzbuzz_list} =
      FizzBuzzGenerator.get_between_values(socket.assigns.start_range, socket.assigns.end_range)

    socket = assign(socket, fizzbuzz_list: fizzbuzz_list)

    {:noreply, socket}
  end

  def handle_event("unfavourite", %{"key" => key}, socket) do
    FavouritesCache.delete_favourite(String.to_integer(key))

    {:ok, fizzbuzz_list} =
      FizzBuzzGenerator.get_between_values(socket.assigns.start_range, socket.assigns.end_range)

    socket = assign(socket, fizzbuzz_list: fizzbuzz_list)

    {:noreply, socket}
  end

  def handle_event("set_range", %{"start_range" => start_range, "end_range" => end_range}, socket) do
    # Handle the range values here as needed
    start_range = String.to_integer(start_range)
    end_range = String.to_integer(end_range)
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_between_values(start_range, end_range)
    total_pages = total_pages(fizzbuzz_list, socket.assigns.page_size)

    socket =
      assign(socket, fizzbuzz_list: fizzbuzz_list)
      |> assign(:start_range, start_range)
      |> assign(:end_range, end_range)
      |> assign(:page, 1)
      |> assign(:total_pages, total_pages)

    {:noreply, socket}
  end

  defp total_pages(fizzbuzz_list, page_size) do
    list_count = Enum.count(fizzbuzz_list)
    pages = div(list_count, page_size)

    page_remainder = rem(list_count, page_size)

    unless page_remainder == 0 do
      pages + 1
    else
      pages
    end
  end
end
