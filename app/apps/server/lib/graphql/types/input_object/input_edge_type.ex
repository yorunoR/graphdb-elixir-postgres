defmodule Graphql.Types.InputObject.InputEdgeType do
  use Absinthe.Schema.Notation

  input_object :input_edge_type do
    field(:name, :string)
    field(:uid, :string)
  end
end
