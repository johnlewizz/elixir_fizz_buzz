defmodule FizzBuzz.FavouritesCacheTest do
  use ExUnit.Case
  alias FizzBuzz.FavouritesCache

  @test_table_name :favourites_test

  setup do
    {:ok, _pid} = FavouritesCache.start_link(table_name: @test_table_name)
    :ok
  end

  test "add_favourite and get_favourite" do
    key = 1
    value = "Fizz"

    FavouritesCache.add_favourite(@test_table_name, key, value)

    assert FavouritesCache.get_favourite(@test_table_name, key) == true
  end

  test "delete_favourite" do
    key = 1
    value = "Fizz"

    FavouritesCache.add_favourite(@test_table_name, key, value)
    FavouritesCache.delete_favourite(@test_table_name, key)

    assert FavouritesCache.get_favourite(@test_table_name, key) == false
  end
end
