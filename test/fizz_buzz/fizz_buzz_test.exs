defmodule FizzBuzz.FizzBuzzGeneratorTest do
  use ExUnit.Case, async: true

  alias FizzBuzz.FizzBuzzGenerator
  alias FizzBuzz.FavouritesCache

  @table_name :favourites_test3

  setup do
    # Start the FavouritesCache with the test table name
    FavouritesCache.start_link(table_name: @table_name)

    # Make sure the test table is empty
    :dets.delete_all_objects(@table_name)

    :ok
  end

  test "get_homepage_values/0 returns the first 100 fizzbuzz values" do
    {:ok, result} = FizzBuzzGenerator.get_homepage_values()
    assert length(result) == 100
  end

  test "get_between_values/2 returns an error if start value is greater than end value" do
    assert FizzBuzzGenerator.get_between_values(5, 1) ==
             {:error, "Start value greater than end value"}
  end

  test "get_between_values/2 returns fizzbuzz values between start and end values" do
    {:ok, result} = FizzBuzzGenerator.get_between_values(1, 5)
    assert length(result) == 5

    {:ok, result} = FizzBuzzGenerator.get_between_values(1, 10000)
    assert length(result) == 10_000

    {:ok, result} = FizzBuzzGenerator.get_between_values(99_999_900_001, 100_000_000_000)
    assert length(result) == 100_000
  end

  test "do_fizz_buzz/1 returns the correct fizzbuzz value for a number" do
    assert FizzBuzzGenerator.fizz_buzz_check(3) == %{id: 3, value: "fizz"}
    assert FizzBuzzGenerator.fizz_buzz_check(5) == %{id: 5, value: "buzz"}
    assert FizzBuzzGenerator.fizz_buzz_check(15) == %{id: 15, value: "fizzbuzz"}
    assert FizzBuzzGenerator.fizz_buzz_check(7) == %{id: 7, value: "7"}
  end

  test "do_fizz_buzz/1 handles large numbers correctly" do
    assert FizzBuzzGenerator.fizz_buzz_check(1_000_000) == %{id: 1_000_000, value: "buzz"}
    assert FizzBuzzGenerator.fizz_buzz_check(3_000_000) == %{id: 3_000_000, value: "fizzbuzz"}
    assert FizzBuzzGenerator.fizz_buzz_check(5_000_000) == %{id: 5_000_000, value: "buzz"}
    assert FizzBuzzGenerator.fizz_buzz_check(15_000_000) == %{id: 15_000_000, value: "fizzbuzz"}
  end
end
