defmodule ElixirFizzBuzzWeb.FizzBuzzLive do
  use ElixirFizzBuzzWeb, :live_view
  alias FizzBuzz.FizzBuzzGenerator

  def mount(_params, _session, socket) do
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_homepage_values()
    #TODO set pagesize according to container size
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
              <td><button phx-click="favourite">♥</button></td>
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
    IO.inspect("Next Page")
    page = min(socket.assigns.page + 1, total_pages(socket))
    {:noreply, assign(socket, page: page)}
  end

  defp total_pages(socket) do
    list_count = Enum.count(socket.assigns.fizzbuzz_list)
      pages = div(list_count, socket.assigns.page_size)

    page_remainder =
      rem(list_count, socket.assigns.page_size)

      unless page_remainder == 0 do
        pages + 1
      else
        pages
      end
  end

  defp favourite("favourite", _params, socket) do
    # TODO add number to favourite
    IO.inspect("Favourite")
    {:noreply, socket}
  end
end
