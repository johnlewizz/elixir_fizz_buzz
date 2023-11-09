defmodule ElixirFizzBuzzWeb.FizzBuzzTableComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <table class="table table-responsive table-style">
      <thead class="thead-style">
        <tr>
          <th class="th-style">Number</th>
          <th class="th-style d-none d-md-table-cell">Result</th>
          <th class="th-style d-none d-md-table-cell">Favourite</th>
        </tr>
      </thead>

      <tbody>
        <%= for item <- Enum.slice(assigns.fizzbuzz_list, (assigns.page - 1) * assigns.page_size, assigns.page_size) do %>
          <tr>
            <td class="td-style"><%= item.id %></td>
            <td class="td-style"><%= item.value %></td>

            <%= if item.favourited do %>
              <td class="td-style">
                <button phx-click="unfavourite" phx-value-key={item.id} class="button-style">
                  ❤
                </button>
              </td>
            <% else %>
              <td class="td-style">
                <button
                  phx-click="favourite"
                  phx-value-key={item.id}
                  phx-value-result={item.value}
                  class="button-style"
                >
                  ♥
                </button>
              </td>
            <% end %>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end
end
