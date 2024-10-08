defmodule Graphql.Types.AccountType do
  use Absinthe.Schema.Notation

  alias Resolvers.AccountResolver

  object :account_queries do
    field(:current_user, non_null(:user)) do
      resolve(fn _parent, _args, %{context: context} ->
        {:ok, context.current_user}
      end)
    end

    field(:current_project, :project) do
      resolve(fn _parent, _args, %{context: context} ->
        {:ok, context.current_project}
      end)
    end
  end

  object :account_mutations do
    field(:signin_user, :user) do
      resolve(&AccountResolver.call(:signin_user, &1, &2, &3))
    end

    field(:signin_guest, :user) do
      resolve(&AccountResolver.call(:signin_guest, &1, &2, &3))
    end

    field(:create_project, :project) do
      arg(:project, non_null(:input_project))
      resolve(&AccountResolver.call(:create_project, &1, &2, &3))
    end

    field(:create_api_key, :api_key) do
      arg(:api_key, non_null(:input_api_key))
      resolve(&AccountResolver.call(:create_api_key, &1, &2, &3))
    end
  end

  object :account_subscriptions do
    field :new_user, non_null(:user) do
      config(fn _args, _ ->
        {:ok, topic: "*"}
      end)
    end
  end
end
