defmodule Graphql.Types.ResourceObject.NodeField do
  use Absinthe.Schema.Notation

  object :node_field do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:type, non_null(:string))
    field(:uid, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end
end
