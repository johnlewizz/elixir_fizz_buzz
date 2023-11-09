defmodule ElixirFizzBuzzWeb.FizzBuzzFormComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <form phx-submit="set_range" class="form-style">
      <label for="start_range" class="label-style">Start Range</label>
      <input name="start_range" type="number" class="input-style" value={@start_range} />

      <label for="end_range" class="label-style">End Range</label>
      <input name="end_range" type="number" class="input-style" value={@end_range} />

      <label for="page_size" class="label-style">Page Size</label>
      <select name="page_size" class="select-style">
        <option value="10">10</option>
        <option value="20">20</option>
        <option value="50">50</option>
        <option value="100">100</option>
        <option value="200">200</option>
      </select>

      <button type="submit" class="button-style">Submit</button>
    </form>
    """
  end
end
