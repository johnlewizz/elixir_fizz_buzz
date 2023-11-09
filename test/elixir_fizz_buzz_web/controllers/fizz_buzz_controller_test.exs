defmodule ElixirFizzBuzzWeb.FizzBuzzControllerTest do
  use ElixirFizzBuzzWeb.ConnCase
  alias ElixirFizzBuzzWeb.FizzBuzzController

  # test "get_values_between/2 returns the fizzbuzz values between the given range", %{conn: conn} do
  #   conn = get(conn, fizz_buzz_path(conn, :get_values_between), %{"start_range" => "1", "end_range" => "15"})
  #   assert json_response(conn, 200) == %{data: ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz"]}
  # end

  # test "get_homepage_values/2 returns the fizzbuzz values for the homepage", %{conn: conn} do
  #   conn = get(conn, fizz_buzz_path(conn, :get_homepage_values))
  #   assert json_response(conn, 200) == %{data: ["1", "2", "Fizz", "4", "Buzz"]}
  # end

  # test "set_favourite/2 adds a number to the favourites list", %{conn: conn} do
  #   conn = post(conn, fizz_buzz_path(conn, :set_favourite), %{"number" => "3", "value" => "Fizz"})
  #   assert json_response(conn, 200) == %{message: "ok"}
  # end

  # test "delete_favourite/2 removes a number from the favourites list", %{conn: conn} do
  #   conn = delete(conn, fizz_buzz_path(conn, :delete_favourite), %{"number" => "3"})
  #   assert json_response(conn, 200) == %{message: "ok"}
  # end
end
