defmodule FizzBuzz.FavouritesCache do
  use GenServer
  @table_name :favourites

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: opts[:table_name] || @table_name)
  end

  def init(opts) do
    table_name = opts[:table_name] || @table_name
    {:ok, _} = :dets.open_file(table_name, [])
    {:ok, %{table_name: table_name}}
  end

  @spec get_favourite(atom(), non_neg_integer()) :: boolean()
  def get_favourite(table_name \\ @table_name, key) do
    GenServer.call(table_name, {:get_favourite, table_name, key})
  end

  @spec delete_favourite(atom(), non_neg_integer()) :: :ok
  def delete_favourite(table_name \\ @table_name, key) do
    GenServer.call(table_name, {:delete_favourite, table_name, key})
  end

  @spec add_favourite(atom(), non_neg_integer(), String.t()) :: :ok
  def add_favourite(table_name \\ @table_name, key, value) do
    GenServer.call(table_name, {:add_favourite, table_name, key, value})
  end

  def handle_call({:get_favourite, table_name, key}, _from, state) do
    case :dets.lookup(state.table_name, key) do
      [{^key, _value}] -> {:reply, true, state}
      [] -> {:reply, false, state}
    end
  end

  def handle_call({:delete_favourite, table_name, key}, _from, state) do
    :dets.delete(state.table_name, key)
    {:reply, :ok, state}
  end

  def handle_call({:add_favourite, table_name, key, value}, _from, state) do
    :dets.insert(state.table_name, {key, value})
    {:reply, :ok, state}
  end
end
