defmodule Actions.Account.Mutation.SigninGuest do
  import U7406

  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def run(_parent, _args, context) do
    %{uid: uid, anonymous: true} = context

    case uid do
      nil -> {:ok, nil}
      uid -> {:ok, find_or_create_user(uid)}
    end
  end

  def find_or_create_user(uid) do
    user = Repo.get_by(User, uid: uid)

    case user do
      %User{} ->
        user

      _ ->
        user_params = %{name: "Anonymous", activated: false, uid: uid, anonymous: true}
        user = struct(User, user_params) |> Repo.insert!()

        project = Repo.get_by!(Project, project_key: "---ThisIsAnAnonymousProject.----")
        build_assoc(user, :project_users, %{project: project, privilege: 1}) |> Repo.insert!()

        user
    end
  end
end
