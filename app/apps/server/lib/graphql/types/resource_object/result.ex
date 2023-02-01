defmodule Graphql.Types.ResourceObject.Result do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :result do
    field(:id, :id)
    field(:name, :string)
    field(:inserted_at, :datetime)
    field(:updated_at, :datetime)

    field(:props, non_null(list_of(non_null(:item)))) do
      resolve(fn parent, _args, %{context: _context} ->
        {:ok, Utils.map_to_list(parent.props)}
      end)
    end

    field(:sub_graph_filter, non_null(:sub_graph_filter)) do
      resolve(dataloader(:db))
    end
  end
end
