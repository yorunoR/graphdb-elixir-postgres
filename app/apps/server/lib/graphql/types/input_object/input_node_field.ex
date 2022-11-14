defmodule Graphql.Types.InputObject.InputNodeField do
  use Absinthe.Schema.Notation

  input_object :input_node_field do
    field(:name, :string)
    field(:type, non_null(:string))
    field(:uid, non_null(:string))
  end
end
