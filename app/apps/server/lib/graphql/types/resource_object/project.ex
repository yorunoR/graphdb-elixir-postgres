defmodule Graphql.Types.ResourceObject.Project do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :project do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:default, non_null(:boolean))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    field(:towers, non_null(list_of(non_null(:tower)))) do
      resolve(dataloader(:db))
    end

    field(:api_keys, non_null(list_of(non_null(:api_key)))) do
      resolve(dataloader(:db))
    end
  end
end
