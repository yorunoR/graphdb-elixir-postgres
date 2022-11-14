defmodule Graphql.Types.ResourceObject.EdgeType do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :edge_type do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:edge_fields, non_null(list_of(non_null(:edge_field)))) do
      resolve(dataloader(:db))
    end

    field(:rules, non_null(list_of(non_null(:rule)))) do
      resolve(dataloader(:db))
    end
  end
end
