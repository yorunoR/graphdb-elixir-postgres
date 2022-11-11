defmodule Graphql.Resolvers.AccountResolver do
  alias Actions.Account.Mutation
  alias Actions.Account.Query
  alias Schemas.Account.User

  def call(action, parent, args, %{context: context}) do
    case action do
      action when action in [:signin_user, :user_and_project] ->
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
      :user_and_project ->
        Query.UserAndProject.run(parent, args, context)

      :signin_user ->
        Mutation.SigninUser.run(parent, args, context)

      :create_project ->
        Mutation.CreateProject.run(parent, args, context)

      _ ->
        {:error, "Not defined in Account context"}
    end
  end
end
