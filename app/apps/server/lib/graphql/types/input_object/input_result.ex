defmodule Graphql.Types.InputObject.InputResult do
  use Absinthe.Schema.Notation

  input_object :input_result do
    field(:name, non_null(:string))
    field(:args, list_of(:string))
    field(:opened_at, non_null(:datetime))
    field(:division_changed_at, non_null(:datetime))
    field(:sub_graph_filter_changed_at, non_null(:datetime))
    field(:props, list_of(:input_item))
  end
end
