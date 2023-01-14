defmodule Graphql.Types.InputObject.InputApiKey do
  use Absinthe.Schema.Notation

  input_object :input_api_key do
    field(:name, non_null(:string))
  end
end
