defmodule FizzBuzz.FavouritesCache do
  @table_name :favourites

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  def start_link(opts \\ []) do
    Task.start_link(fn ->
      {:ok, _} = :dets.open_file(opts[:table_name] || @table_name, opts)
      Process.hibernate(Function, :identity, [nil])
    end)
  end

  @spec get_favourite(table_name :: atom(), key :: non_neg_integer()) ::
          {atom(), {non_neg_integer(), String.t()}}
  def get_favourite(table_name \\ @table_name, key) do
    case :dets.lookup(table_name, key) do
      [{^key, value}] -> true
      [] -> false
    end
  end

  @spec delete_favourite(table_name :: atom(), key :: non_neg_integer()) :: atom()
  def delete_favourite(table_name \\ @table_name, key) do
    :dets.delete(table_name, key)
  end

  @spec add_favourite(table_name :: atom(), key :: non_neg_integer()) :: atom()
  def add_favourite(table_name \\ @table_name, key, value) do
    :dets.insert(table_name, {key, value})
  end
end
