defmodule ElixirFizzBuzzWeb.FizzBuzzLive do
  use ElixirFizzBuzzWeb, :live_view
  alias FizzBuzz.FizzBuzzGenerator
  alias FizzBuzz.FavouritesCache

  def mount(_params, _session, socket) do
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_homepage_values()
    # TODO set pagesize according to container size
    page_size = 20

    socket =
      assign(socket, fizzbuzz_list: fizzbuzz_list, page: 1, page_size: page_size)
      |> add_styling()

    {:ok, socket}
  end

  def render(assigns) do
    container_style = "width: 100%; margin: 0 auto;"
    table_style = "width: 100%; border-collapse: collapse;"
    thead_style = "background-color: #f2f2f2;"
    th_style = "padding: 8px; border-bottom: 1px solid #ddd; text-align: center;"
    td_style = "padding: 8px; border-bottom: 1px solid #ddd; text-align: center;"

    button_style =
      "background-color: #00008B; color: white; padding: 10px; width: 100px; border: none; border-radius: 4px; cursor: pointer;"

    margin_right = "margin-right: 5px;"
    margin_left = "margin-left: 5px;"

    ~H"""
    <div class="container" style={container_style}>
      <table class="table table-responsive" style={table_style}>
        <thead style={thead_style}>
          <tr>
            <th style={th_style}>Number</th>
            <th class="d-none d-md-table-cell" style={th_style}>Result</th>
            <th class="d-none d-md-table-cell" style={th_style}>Favourite</th>
          </tr>
        </thead>
        <tbody>
          <%= for item <- Enum.slice(assigns.fizzbuzz_list, (assigns.page - 1) * assigns.page_size, assigns.page_size) do %>
            <tr>
              <td style={td_style}><%= item.id %></td>
              <td style={td_style}><%= item.value %></td>
              <%= if item.favourited do %>
                <td style={td_style}>
                  <button phx-click="unfavourite" phx-value-key={item.id} style={button_style}>
                    ❤
                  </button>
                </td>
              <% else %>
                <td style={td_style}>
                  <button
                    phx-click="favourite"
                    phx-value-key={item.id}
                    phx-value-result={item.value}
                    style={button_style}
                  >
                    ♥
                  </button>
                </td>
              <% end %>
            </tr>
          <% end %>
        </tbody>
      </table>
      <div>
        <button phx-click="prev_page" style={button_style <> margin_right}>Previous</button>
        <span>Page <%= assigns.page %></span>
        <button phx-click="next_page" style={button_style <> margin_left}>Next</button>
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
    FavouritesCache.add_favourite(int_key, value)
    {:noreply, socket}
  end

  def handle_event("unfavourite", %{"key" => key}, socket) do
    FavouritesCache.delete_favourite(String.to_integer(key))
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

  defp add_styling(socket) do
    container_style = "width: 100%; margin: 0 auto;"
    table_style = "width: 100%; border-collapse: collapse;"
    thead_style = "background-color: #f2f2f2;"
    th_style = "padding: 8px; border-bottom: 1px solid #ddd; text-align: center;"
    td_style = "padding: 8px; border-bottom: 1px solid #ddd; text-align: center;"

    button_style =
      "background-color: #00008B; color: white; padding: 10px; width: 100px; border: none; border-radius: 4px; cursor: pointer;"

    margin_right = "margin-right: 5px;"
    margin_left = "margin-left: 5px;"

    socket =
      assign(socket, :container_style, container_style)
      |> assign(:table_style, table_style)
      |> assign(:thead_style, thead_style)
      |> assign(:th_style, th_style)
      |> assign(:td_style, td_style)
      |> assign(:button_style, button_style)
      |> assign(:margin_right, margin_right)
      |> assign(:margin_left, margin_left)
  end
end
