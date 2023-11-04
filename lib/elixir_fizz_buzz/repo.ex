defmodule ElixirFizzBuzz.Repo do
  use Ecto.Repo,
    otp_app: :elixir_fizz_buzz,
    adapter: Ecto.Adapters.Postgres
end
