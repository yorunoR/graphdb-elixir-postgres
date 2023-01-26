defmodule Graphql.Types.CustomObject.SubGraphStatus do
  use Absinthe.Schema.Notation

  object :sub_graph_status do
    field(:status, :boolean)
    field(:nodes, :integer)
    field(:edges, :integer)
    field(:opened_at, :datetime)
  end
end
