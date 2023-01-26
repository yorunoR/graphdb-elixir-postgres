defmodule Graphql.Types.CustomObject.LibgraphStatus do
  use Absinthe.Schema.Notation

  object :libgraph_status do
    field(:status, :boolean)
    field(:opened_at, :datetime)
  end
end
