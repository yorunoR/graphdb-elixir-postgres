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

    field(:divisions, non_null(:division_list)) do
      arg(:offset, :integer, default_value: 0)
      arg(:limit, :integer, default_value: 10)

      resolve(
        dataloader(:db,
          callback: &Db.graph_pagination_callback(&1, &2, &3, [:tower_summary, "divisionCount"])
        )
      )
    end

    field(:summary, non_null(list_of(non_null(:item)))) do
      resolve(&GraphResolver.call(:tower_summary, &1, &2, &3))
    end
  end
end
