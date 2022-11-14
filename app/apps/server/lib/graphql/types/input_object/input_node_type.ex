defmodule Graphql.Types.InputObject.InputNodeType do
  use Absinthe.Schema.Notation

  input_object :input_node_type do
    field(:name, :string)
    field(:uid, :string)
  end
end
