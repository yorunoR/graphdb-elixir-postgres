defmodule Actions.Account.Query.ProjectAndHash do
  import U7406

  alias Schemas.Account.Project
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{project_key: project_key, short_token: short_token} = args

    project = Repo.get_by(Project, project_key: project_key)

    api_keys =
      case project do
        %Project{} ->
          Repo.as_admin(fn ->
            assoc(project, :api_keys) |> Repo.all()
          end)

        _ ->
          []
      end

    hash =
      api_keys
      |> Enum.find(%{}, &(&1.short_token == short_token))
      |> Map.get(:hash)

    {:ok, {project, hash}}
  end
end
