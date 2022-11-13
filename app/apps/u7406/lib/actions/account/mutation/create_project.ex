defmodule Actions.Account.Mutation.CreateProject do
  import Ecto.Changeset
  import U7406

  alias Ecto.Multi
  alias Schemas.Account.Project
  alias U7406.Repo

  def run(_parent, args, context) do
    %{current_user: user} = context
    %{project: attrs} = args

    Multi.new()
    |> Multi.run(:create_project, &create_project(&1, &2, user, attrs))
    |> Repo.transaction()
    |> transaction_result()
  end

  def create_project(repo, _run, user, attrs) do
    project =
      %Project{}
      |> create_project_changeset(attrs)
      |> repo.insert!

    build_assoc(user, :project_users, %{project: project, privilege: 0}) |> repo.insert!
    {:ok, project}
  end

  def create_project_changeset(%Project{} = project, attrs) do
    project
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end

  def transaction_result({:ok, %{create_project: project}}) do
    {:ok, project}
  end
end
