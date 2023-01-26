defmodule Resolvers.AccountResolver do
  alias Actions.Account.Mutation
  alias Actions.Account.Query
  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def call(action, parent, args, %{context: context}) do
    case action do
      action when action in [:signin_user, :user_and_project, :project_and_hash] ->
        run(action, parent, args, context)

      :create_api_key ->
        with %Project{} = project <- Map.get(context, :current_project) do
          Repo.as_user(project.id, fn ->
            run(action, parent, args, context)
          end)
        else
          _ -> {:error, "No current project"}
        end

      :create_project ->
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

      :project_and_hash ->
        Query.ProjectAndHash.run(parent, args, context)

      :signin_user ->
        Mutation.SigninUser.run(parent, args, context)

      :create_project ->
        Mutation.CreateProject.run(parent, args, context)

      :create_api_key ->
        Mutation.CreateApiKey.run(parent, args, context)

      _ ->
        {:error, "Not defined in Account context"}
    end
  end
end
