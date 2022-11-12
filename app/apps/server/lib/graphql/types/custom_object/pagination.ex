defmodule Graphql.Types.CustomObject.Pagination do
  use Absinthe.Schema.Notation

  object :pagination do
    field(:offset, non_null(:integer))
    field(:limit, non_null(:integer))
    field(:total, non_null(:integer))
  end
end
