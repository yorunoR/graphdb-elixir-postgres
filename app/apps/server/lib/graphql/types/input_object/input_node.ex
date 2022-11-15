defmodule Graphql.Types.InputObject.InputNode do
  use Absinthe.Schema.Notation

  input_object :input_node do
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:node_type_id, non_null(:string))
    field(:props, list_of(:input_item))
  end
end
