defmodule Graphql.Types.ResourceObject.Tower do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  alias Graphql.Resolvers.GraphResolver
  alias Graphql.Sources.Db

  object :tower do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:public, non_null(:boolean))
    field(:inheritable, non_null(:boolean))
    field(:inherited_at, :datetime)
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:project, non_null(:project)) do
      resolve(dataloader(:db))
    end

    field(:tower, :tower) do
      resolve(dataloader(:db))
    end

    # field(:divisions, non_null(list_of(non_null(:division)))) do
    #   arg(:offset, :integer)
    #   arg(:limit, :integer)

    #   resolve(
    #     dataloader(:db,
    #       callback: &Db.graph_pagination_callback(&1, &2, &3, [:tower_summary, :division_count])
    #     )
    #   )
    # end
  end
end
