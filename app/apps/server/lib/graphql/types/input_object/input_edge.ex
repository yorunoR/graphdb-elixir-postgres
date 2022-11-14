defmodule Graphql.Types.InputObject.InputEdge do
  use Absinthe.Schema.Notation

  input_object :input_edge do
    field(:name, non_null(:string))
    field(:start_node_uid, :string)
    field(:end_node_uid, :string)
    field(:edge_type_id, non_null(:string))
    field(:props, list_of(:input_item))
  end
end
