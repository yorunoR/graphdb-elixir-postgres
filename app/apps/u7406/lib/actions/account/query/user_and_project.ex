defmodule Actions.Account.Query.UserAndProject do
  import U7406

  alias Schemas.Account.Project
  alias Schemas.Account.User
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{uid: uid, project_id: project_id} = args

    user = Repo.get_by(User, uid: uid)

    project = get_project(user, project_id)

    {:ok, {user, project}}
  end

  def get_project(%User{anonymous: true}, _) do
    Repo.get_by!(Project, project_key: "---ThisIsAnAnonymousProject.----")
  end

  def get_project(%User{} = user, project_id) do
    projects = assoc(user, :projects) |> Repo.all()

    case project_id do
      0 -> projects |> Enum.find(&(&1.default == true))
      _ -> projects |> Enum.find(&(&1.id == project_id))
    end
  end

  def get_project(_, _) do
    nil
  end
end
