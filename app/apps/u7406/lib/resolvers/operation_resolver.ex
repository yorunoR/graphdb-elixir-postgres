defmodule Resolvers.OperationResolver do
  alias Actions.Operation.CustomField
  alias Actions.Operation.Mutation
  alias Actions.Operation.Query
  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def call(action, parent, args, %{context: context}) do
    case action do
      action when action in [] ->
        Repo.as_admin(fn ->
          run(action, parent, args, context)
        end)

      _ ->
        with %User{} <- Map.get(context, :current_user),
             %Project{} = project <- Map.get(context, :current_project) do
          Repo.as_user(project.id, fn ->
            run(action, parent, args, context)
          end)
        else
          _ -> {:error, "No current user or current project"}
        end
    end
  end

  def admin_call(action, parent, args, %{context: context}) do
    Repo.as_admin(fn ->
      run(action, parent, args, context)
    end)
  end

  def run(action, parent, args, context) do
    case action do
      :upload_nodes ->
        Mutation.UploadNodes.run(parent, args, context)

      :upload_edges ->
        Mutation.UploadEdges.run(parent, args, context)

      _ ->
        {:error, "Not defined in Operation context"}
    end
  end
end
