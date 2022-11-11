defmodule Graphql.Types.InputObject.InputTower do
  use Absinthe.Schema.Notation

  input_object :input_tower do
    field(:name, non_null(:string))
    field(:public, :boolean)
    field(:inheritable, :boolean)
  end
end
