defmodule Graphql.Types.ResourceObject.SubGraphFilter do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :sub_graph_filter do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:uid, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:node_filter, :node_filter)
    field(:edge_filter, :edge_filter)

    field(:project, non_null(:project)) do
      resolve(dataloader(:db))
    end

    field(:tower, non_null(:tower)) do
      resolve(dataloader(:db))
    end

    field(:division, non_null(:division)) do
      resolve(dataloader(:db))
    end
  end

  object :node_filter do
    field(:uids, list_of(:string))
  end

  object :edge_filter do
    field(:edge_types, list_of(:string))
  end
end
