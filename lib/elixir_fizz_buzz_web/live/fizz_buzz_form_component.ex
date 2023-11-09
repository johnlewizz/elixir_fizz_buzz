defmodule ElixirFizzBuzzWeb.FizzBuzzFormComponent do
  use Phoenix.LiveComponent

  def render(assigns) do
    ~H"""
    <form phx-submit="set_range" class="form-style">
      <label for="start_range" class="label-style">Start Range</label>
      <input name="start_range" type="number" class="input-style" value={@start_range} />
      <label for="end_range" class="label-style">End Range</label>
      <input name="end_range" type="number" class="input-style" value={@end_range} />
      <button type="submit" class="button-style">Submit</button>
    </form>
    """
  end
end
