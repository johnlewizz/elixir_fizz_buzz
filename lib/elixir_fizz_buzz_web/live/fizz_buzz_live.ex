defmodule ElixirFizzBuzzWeb.FizzBuzzLive do
  use ElixirFizzBuzzWeb, :live_view

  def mount(_params, _session, socket) do
    socket = assign(socket, :value, 10)
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>Fizz Buzz</h1>
    <%= @value %>
    """
  end
end
