defmodule Graphql.Types.ResourceObject.Rule do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :rule do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:direction, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:start_node_type, non_null(:node_type)) do
      resolve(dataloader(:db))
    end

    field(:end_node_type, non_null(:node_type)) do
      resolve(dataloader(:db))
    end
  end
end
