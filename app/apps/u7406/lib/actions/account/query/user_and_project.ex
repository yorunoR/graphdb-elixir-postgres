defmodule Actions.Account.Query.UserAndProject do
  import U7406

  alias Schemas.Account.User
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{uid: uid, project_id: project_id} = args

    user = Repo.get_by(User, uid: uid)

    projects =
      case user do
        %User{} -> assoc(user, :projects) |> Repo.all()
        _ -> []
      end

    project =
      case project_id do
        0 -> projects |> Enum.find(&(&1.default == true))
        _ -> projects |> Enum.find(&(&1.id == project_id))
      end

    {:ok, {user, project}}
  end
end
