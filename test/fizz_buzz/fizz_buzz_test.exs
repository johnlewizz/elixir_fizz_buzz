defmodule FizzBuzz.FizzBuzzTest do
  use ExUnit.Case
  # Test generates values 1-100 using fizzbuzz
  test "generate home page values" do

    #TODO validate return values
    result =
    FizzBuzz.get_homepage_values()
    |> case do
      {:ok, values} -> true
      _ -> false
    end
    assert result
  end

  # Will test different inputs within the expected range
  test "generate range of values" do
    input_values =
    [{101, 200}, {201, 300}, {1001, 2000}, {999_999_999_000, 100_000_000_000}]
    Enum.each(input_values, fn {start_value, end_value} ->
     result = FizzBuzz.get_between_values(start_value, end_value)
      |> case do
        {:ok, _values} -> true
        _-> false
        end
    assert result
    end)
  end

  test "set number as favourite" do
    #TOD0 set a new number as a favourite
    assert true
  end

  # Will return a list of favourite numbers
  test "request list of favourites" do
    assert true
  end

  # Removes a number from the stored favourites
  test "remove number as a favourite" do
    assert true
  end
end
