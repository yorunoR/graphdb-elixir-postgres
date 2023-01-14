defmodule Graphql.Types.ResourceObject.ApiKey do
  use Absinthe.Schema.Notation

  object :api_key do
    field(:id, non_null(:id))
    field(:name, non_null(:string))
    field(:short_token, non_null(:string))
    field(:inserted_at, non_null(:datetime))
    field(:updated_at, non_null(:datetime))
  end
end
