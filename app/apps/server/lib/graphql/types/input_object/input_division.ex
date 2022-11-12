defmodule Graphql.Types.InputObject.InputDivision do
  use Absinthe.Schema.Notation

  input_object :input_division do
    field(:name, non_null(:string))
  end
end
