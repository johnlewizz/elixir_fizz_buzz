defmodule ElixirFizzBuzzWeb.FizzBuzzController do
  import Jason
  use ElixirFizzBuzzWeb, :controller
  alias FizzBuzz.FizzBuzzGenerator
  alias FizzBuzz.FavouritesCache

  def get_values_between(conn, %{"start_range" => start_range, "end_range" => end_range}) do
    start_range = String.to_integer(start_range)
    end_range = String.to_integer(end_range)
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_between_values(start_range, end_range)
    data = encode!(fizzbuzz_list)
    json(conn, data)
  end

  def get_homepage_values(conn, _params) do
    {:ok, fizzbuzz_list} = FizzBuzzGenerator.get_homepage_values()
    data = encode!(fizzbuzz_list)
    json(conn, data)
  end

  # TODO write :dets request to get all favourites
  def get_favourites(conn, _params) do
    data = %{message: ""}
    json(conn, data)
  end

  # TODO handle failure to add favourite
  def set_favourite(conn, %{"number" => number, "value" => value}) do
    String.to_integer(number)
    |> FavouritesCache.add_favourite(value)

    data = %{message: "ok"}
    json(conn, data)
  end

  # TODO handle failure to delete favourite
  def delete_favourite(conn, %{"number" => number}) do
    String.to_integer(number)
    |> FavouritesCache.delete_favourite()

    data = %{message: "ok"}
    json(conn, data)
  end
end
