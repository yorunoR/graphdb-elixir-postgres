defmodule Graphql.Types.InputObject.InputRule do
  use Absinthe.Schema.Notation

  input_object :input_rule do
    field(:name, non_null(:string))
    field(:direction, :string)
    field(:start_node_type_id, non_null(:id))
    field(:end_node_type_id, non_null(:id))
  end
end
