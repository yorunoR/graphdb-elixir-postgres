defmodule Actions.Account.Mutation.SigninUser do
  import Ecto.Changeset
  import U7406

  alias Ecto.Multi
  alias Queries.Account
  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def run(_parent, _args, context) do
    %{email: email, uid: uid, name: name} = context

    case {email, uid, name} do
      {nil, nil, _} ->
        {:ok, nil}

      {email, uid, name} ->
        user = Repo.get_by(User, email: email)

        Multi.new()
        |> Multi.run(
          :update_signin_user,
          &update_signin_user(&1, &2, user, %{uid: uid, name: name})
        )
        |> Multi.run(:create_default_project, &create_default_project(&1, &2, user))
        |> Repo.transaction()
        |> transaction_result()
    end
  end

  def update_signin_user(repo, _run, %User{} = user, attrs) do
    user
    |> signin_user_changeset(attrs)
    |> repo.update()
  end

  def update_signin_user(_repo, _run, nil, _attrs) do
    {:error, :not_found}
  end

  def signin_user_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:uid, :name])
    |> validate_required([:uid])
  end

  def create_default_project(repo, _run, user) do
    default_project = assoc(user, :projects) |> Account.default_projects() |> repo.one

    case default_project do
      %Project{} ->
        {:ok, default_project}

      _ ->
        project = %Project{default: true, name: "Default Project"} |> repo.insert!
        build_assoc(user, :project_users, %{project: project, privilege: 0}) |> repo.insert!
        {:ok, project}
    end
  end

  def transaction_result({:ok, %{update_signin_user: user}}) do
    {:ok, user}
  end

  def transaction_result({:error, _operation, error, _successes}) do
    {:error, error}
  end
end
