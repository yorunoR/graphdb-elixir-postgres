defmodule Graphql.Types.ResourceObject.Project do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers

  object :project do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:default, non_null(:boolean))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))

    # field(:divisions, non_null(list_of(non_null(:division)))) do
    #   resolve(dataloader(:db))
    # end
  end
end
