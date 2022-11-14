defmodule Graphql.Types.InputObject.InputSelections do
  use Absinthe.Schema.Notation

  input_object :input_selections do
    field(:selections, non_null(list_of(non_null(:string))))
  end
end
