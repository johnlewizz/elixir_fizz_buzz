defmodule ElixirFizzBuzzWeb.FizzBuzzPaginationComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <div>
      <%= unless assigns.total_pages == 1 do %>
        <div class="pagination-container">
          <button phx-click="prev_page" class="button-style">Previous</button>
          <span class="pagination-text">Page <%= assigns.page %> of <%= assigns.total_pages %></span>
          <button phx-click="next_page" class="button-style">Next</button>
        </div>
      <% end %>
    </div>
    """
  end
end
