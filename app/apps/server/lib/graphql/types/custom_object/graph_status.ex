defmodule Graphql.Types.CustomObject.GraphStatus do
  use Absinthe.Schema.Notation

  object :graph_status do
    field(:status, :boolean)
    field(:opened_at, :datetime)
    field(:commands, non_null(list_of(non_null(:algorithm))))
  end
end
