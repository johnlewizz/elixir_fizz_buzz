defmodule FizzBuzz.FizzBuzzTest do
  use ExUnit.Case
  # Test generates values 1-100 using fizzbuzz
  test "generate home page values" do

    #TODO validate return values
    assert FizzBuzz.get_homepage_values() == {:ok, _values}
  end

  test "generate range of values" do
    input_values =
    [{101, 200}, {201, 300}, {1001, 2000}, {999_999_999_000, 100_000_000_000}]
    Enum.each( input_values, fn {start_value, end_value} ->
    assert FizzBuzz.get_between_values(start_value, end_value) == {:ok, _values}
    end)
  end
end
