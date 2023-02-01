defmodule Utils do
  def list_to_map(list) do
    Enum.reduce(list, %{}, fn item, acc ->
      Map.put(acc, item.key, item.val)
    end)
  end

  def map_to_list(%{} = map) do
    Enum.map(map, fn {key, value} ->
      %{key: key, val: value}
    end)
  end

  def map_to_list(list) when is_list(list) do
    Enum.with_index(list, fn value, index ->
      %{key: index, val: value}
    end)
  end

  def map_to_list(_) do
    []
  end
end
