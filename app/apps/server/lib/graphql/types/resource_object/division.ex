defmodule Graphql.Types.ResourceObject.Division do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias Graphql.Sources.Db
  alias Resolvers.GraphResolver

  object :division do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:division_hash, non_null(:string))
    field(:changed_at, :datetime)
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:project, non_null(:project)) do
      resolve(dataloader(:db))
    end

    field(:tower, non_null(:tower)) do
      resolve(dataloader(:db))
    end

    # field(:node_types, non_null(list_of(non_null(:node_type)))) do
    #   resolve(dataloader(:db))
    # end

    # field(:edge_types, non_null(list_of(non_null(:edge_type)))) do
    #   resolve(dataloader(:db))
    # end

    # field(:nodes, non_null(:node_list)) do
    #   arg(:offset, :integer)
    #   arg(:limit, :integer)

    #   resolve(
    #     dataloader(:db,
    #       callback: &Db.graph_pagination_callback(&1, &2, &3, [:division_summary, :node_count])
    #     )
    #   )
    # end

    # field(:edges, non_null(:edge_list)) do
    #   arg(:offset, :integer)
    #   arg(:limit, :integer)

    #   resolve(
    #     dataloader(:db,
    #       callback: &Db.graph_pagination_callback(&1, &2, &3, [:division_summary, :edge_count])
    #     )
    #   )
    # end

    # field(:sub_graph_filters, non_null(list_of(non_null(:sub_graph_filter)))) do
    #   resolve(dataloader(:db))
    # end

    # field(:upload_operations, non_null(list_of(non_null(:upload_operation)))) do
    #   resolve(dataloader(:db))
    # end

    field(:summary, non_null(list_of(non_null(:item)))) do
      arg(:selections, non_null(list_of(non_null(:string))))
      resolve(&GraphResolver.call(:division_summary, &1, &2, &3))
    end
  end
end
