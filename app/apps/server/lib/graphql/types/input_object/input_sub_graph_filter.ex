defmodule Graphql.Types.InputObject.InputSubGraphFilter do
  use Absinthe.Schema.Notation

  input_object :input_sub_graph_filter do
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
  end
end
