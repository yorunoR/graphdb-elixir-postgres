defmodule Graphql.Resolvers.AccountResolver do
  alias Actions.Account.Mutation
  alias Schemas.Account.User

  def call(action, parent, args, %{context: context}) do
    case action do
      :signin_user ->
        run(action, parent, args, context)

      _ ->
        with %User{} <- Map.get(context, :current_user) do
          run(action, parent, args, context)
        else
          _ -> {:error, "No current user"}
        end
    end
  end

  def run(action, parent, args, context) do
    case action do
      :signin_user ->
        Mutation.SigninUser.run(parent, args, context)

      :create_project ->
        Mutation.CreateProject.run(parent, args, context)

      _ ->
        {:error, "Not defined in Account context"}
    end
  end
end
