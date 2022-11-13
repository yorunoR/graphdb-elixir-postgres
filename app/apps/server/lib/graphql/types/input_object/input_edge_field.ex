defmodule Graphql.Types.InputObject.InputEdgeField do
  use Absinthe.Schema.Notation

  input_object :input_edge_field do
    field(:name, :string)
    field(:type, non_null(:string))
    field(:uid, non_null(:string))
  end
end
