defmodule Actions.Graph.Mutation.CreateTower do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Tower
  alias U7406.Repo

  def run(_parent, args, context) do
    %{current_project: project} = context
    %{tower: attrs} = args

    tower =
      build_assoc(project, :towers)
      |> create_tower_changeset(attrs)
      |> Repo.insert!()

    {:ok, tower}
  end

  def create_tower_changeset(%Tower{} = tower, attrs) do
    tower
    |> cast(attrs, [:name, :public, :inheritable])
    |> validate_required([:name])
  end
end
