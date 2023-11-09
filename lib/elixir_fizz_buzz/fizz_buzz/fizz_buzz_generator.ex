defmodule FizzBuzz.FizzBuzzGenerator do
  alias FizzBuzz.FavouritesCache
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
    Enum.map(start_value..end_value, &do_fizz_buzz(&1))
  end

  # TODO consider having a ETS cache which periodically saves to :dets for faster lookup performance
  @spec do_fizz_buzz(number :: non_neg_integer()) :: %{
          id: non_neg_integer(),
          value: String.t(),
          favourited: boolean()
        }
  defp do_fizz_buzz(number) do
    favourited = FavouritesCache.get_favourite(number)

    fizz_buzz_check(number)
    |> Map.put(:favourited, favourited)
  end

  @spec fizz_buzz_check(number :: non_neg_integer()) :: %{
          id: non_neg_integer(),
          value: String.t()
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

  defp fizz_buzz_check(number) do
    %{id: number, value: Integer.to_string(number)}
  end
end
