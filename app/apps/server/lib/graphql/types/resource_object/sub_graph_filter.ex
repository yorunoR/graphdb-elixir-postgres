defmodule Graphql.Types.ResourceObject.SubGraphFilter do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :sub_graph_filter do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:node_filter, :string) do
      resolve(fn parent, _args, %{context: _context} ->
        Map.get(parent.node_filter, "q", []) |> Poison.encode()
      end)
    end

    field(:edge_filter, :string) do
      resolve(fn parent, _args, %{context: _context} ->
        Map.get(parent.edge_filter, "q", []) |> Poison.encode()
      end)
    end

    field(:project, non_null(:project)) do
      resolve(dataloader(:db))
    end

    field(:tower, non_null(:tower)) do
      resolve(dataloader(:db))
    end

    field(:division, non_null(:division)) do
      resolve(dataloader(:db))
    end
  end
end
