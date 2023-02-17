defmodule Graphql.Types.CustomObject.NodeList do
  use Absinthe.Schema.Notation

  object :node_list do
    field(:entries, non_null(list_of(non_null(:node))))
    import_fields(:pagination)
  end
end
