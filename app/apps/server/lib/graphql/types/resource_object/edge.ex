defmodule Graphql.Types.ResourceObject.Edge do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :edge do
    field(:id, non_null(:id))
    field(:edge_type_id, non_null(:id))
    field(:name, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:props, non_null(list_of(non_null(:item)))) do
      resolve(fn parent, _args, %{context: _context} ->
        {:ok, Utils.map_to_list(parent.props)}
      end)
    end

    field(:edge_type, non_null(:edge_type)) do
      resolve(dataloader(:db))
    end

    field(:start_node, non_null(:node)) do
      resolve(dataloader(:db))
    end

    field(:end_node, non_null(:node)) do
      resolve(dataloader(:db))
    end
  end
end
