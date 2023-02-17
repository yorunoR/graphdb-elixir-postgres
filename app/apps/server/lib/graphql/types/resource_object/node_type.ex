defmodule Graphql.Types.ResourceObject.NodeType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :node_type do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:node_fields, non_null(list_of(non_null(:node_field)))) do
      resolve(dataloader(:db))
    end
  end
end
