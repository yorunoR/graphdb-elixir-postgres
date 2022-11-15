defmodule Graphql.Types.ResourceObject.Node do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :node do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:node_type_id, non_null(:id))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:props, non_null(list_of(non_null(:item)))) do
      resolve(fn parent, _args, %{context: _context} ->
        {:ok, Utils.map_to_list(parent.props)}
      end)
    end

    field(:node_type, non_null(:node_type)) do
      resolve(dataloader(:db))
    end
  end
end
