defmodule Graphql.Types.CustomObject.EdgeList do
  use Absinthe.Schema.Notation

  object :edge_list do
    field(:entries, non_null(list_of(non_null(:edge))))
    import_fields(:pagination)
  end
end
