defmodule Resolvers.AccountResolver do
  alias Actions.Account.Mutation
  alias Actions.Account.Query
  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def call(action, parent, args, %{context: context}) do
    case action do
      action when action in [:signin_user, :signin_guest, :user_and_project, :project_and_hash] ->
        run(action, parent, args, context)

      :create_api_key ->
        with %Project{} = project <- Map.get(context, :current_project),
             %User{anonymous: false} <- Map.get(context, :current_user) do
          Repo.as_user(project.id, fn ->
            run(action, parent, args, context)
          end)
        else
          _ -> {:error, "No current project"}
        end

      :create_project ->
        with %User{anonymous: false} <- Map.get(context, :current_user) do
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

      :signin_guest ->
        Mutation.SigninGuest.run(parent, args, context)

      :create_project ->
        Mutation.CreateProject.run(parent, args, context)

      :create_api_key ->
        Mutation.CreateApiKey.run(parent, args, context)

      _ ->
        {:error, "Not defined in Account context"}
    end
  end
end
