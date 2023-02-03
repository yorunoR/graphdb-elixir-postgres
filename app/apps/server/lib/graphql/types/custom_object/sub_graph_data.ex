defmodule Graphql.Types.CustomObject.SubGraphData do
  use Absinthe.Schema.Notation

  object :sub_graph_data do
    field(:nodes, non_null(list_of(non_null(:node))))
    field(:edges, non_null(list_of(non_null(:edge))))
  end
end
