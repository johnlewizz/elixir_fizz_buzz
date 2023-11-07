defmodule FizzBuzz.FizzBuzzGenerator do
  @spec get_homepage_values() :: {atom(), String.t()}
  def get_homepage_values() do
    result = fizz_buzz(1, 100)
    {:ok, result}
  end

  @spec get_between_values(start_value :: non_neg_integer(), end_value :: non_neg_integer()) ::
          {atom(), String.t()}
  def get_between_values(start_value, end_value) when start_value > end_value do
    {:error, "Start value greater than end value"}
  end

  def get_between_values(start_value, end_value) do
    result = fizz_buzz(start_value, end_value)
    {:ok, result}
  end

  @spec fizz_buzz(start_value :: non_neg_integer(), end_value :: non_neg_integer()) :: list()
  def fizz_buzz(start_value, end_value) do
    Enum.map(start_value..end_value, &fizz_buzz_check(&1))
  end

  @spec fizz_buzz_check(number :: non_neg_integer()) :: %{
          id: non_neg_integer(),
          value: String.t() | non_neg_integer()
        }
  defp fizz_buzz_check(number) when rem(number, 3) == 0 and rem(number, 5) == 0 do
    %{id: number, value: "fizzbuzz"}
  end

  defp fizz_buzz_check(number) when rem(number, 3) == 0 do
    %{id: number, value: "fizz"}
  end

  defp fizz_buzz_check(number) when rem(number, 5) == 0 do
    %{id: number, value: "buzz"}
  end

  defp fizz_buzz_check(number), do: %{id: number, value: number}
end
