defmodule Graphql.Types.ResourceObject.Algorithm do
  use Absinthe.Schema.Notation

  object :algorithm do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:arity, non_null(:integer))
    field(:description, :string)
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end
end
