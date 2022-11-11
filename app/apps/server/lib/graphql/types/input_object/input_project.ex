defmodule Graphql.Types.InputObject.InputProject do
  use Absinthe.Schema.Notation

  input_object :input_project do
    field(:name, non_null(:string))
  end
end
