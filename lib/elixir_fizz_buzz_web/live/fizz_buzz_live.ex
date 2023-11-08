defmodule ElixirFizzBuzzWeb.FizzBuzzLive do
  use ElixirFizzBuzzWeb, :live_view
  alias FizzBuzz.FizzBuzzGenerator
  alias FizzBuzz.FavouritesCache

  def mount(_params, _session, socket) do
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_homepage_values()
    # TODO set pagesize according to container size
    page_size = 20
    socket = assign(socket, fizzbuzz_list: fizzbuzz_list, page: 1, page_size: page_size)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <div class="container">
      <table class="table table-responsive">
        <thead>
          <tr>
            <th>Number</th>
            <th class="d-none d-md-table-cell">Result</th>
            <th class="d-none d-md-table-cell">Favourite</th>
          </tr>
        </thead>
        <tbody>
          <%= for item <- Enum.slice(assigns.fizzbuzz_list, (assigns.page - 1) * assigns.page_size, assigns.page_size) do %>
            <tr>
              <td><%= item.id %></td>
              <td><%= item.value %></td>
              <%= if item.favourited do %>
                <td>
                  <button phx-click="unfavourite" phx-value-key={item.id}>
                    ❤
                  </button>
                </td>
              <% else %>
                <td>
                  <button phx-click="favourite" phx-value-key={item.id} phx-value-result={item.value}>
                    ♥
                  </button>
                </td>
              <% end %>
            </tr>
          <% end %>
        </tbody>
      </table>
      <div>
        <button phx-click="prev_page">Previous</button>
        <span>Page <%= assigns.page %></span>
        <button phx-click="next_page">Next</button>
      </div>
    </div>
    """
  end

  def handle_event("prev_page", _params, socket) do
    page = max(socket.assigns.page - 1, 1)
    {:noreply, assign(socket, page: page)}
  end

  def handle_event("next_page", _params, socket) do
    page = min(socket.assigns.page + 1, total_pages(socket))
    {:noreply, assign(socket, page: page)}
  end

  def handle_event("favourite", %{"key" => key, "result" => value}, socket) do
    int_key = String.to_integer(key)
    # TODO add number to favourite
    FavouritesCache.add_favourite(int_key, value)
    |> IO.inspect()

    IO.inspect("Favourite")
    {:noreply, socket}
  end

  def handle_event("unfavourite", %{"key" => key}, socket) do
    FavouritesCache.delete_favourite(String.to_integer(key))
    |> IO.inspect()

    IO.inspect("unfavourite")
    {:noreply, socket}
  end

  defp total_pages(socket) do
    list_count = Enum.count(socket.assigns.fizzbuzz_list)
    pages = div(list_count, socket.assigns.page_size)

    page_remainder = rem(list_count, socket.assigns.page_size)

    unless page_remainder == 0 do
      pages + 1
    else
      pages
    end
  end
end
