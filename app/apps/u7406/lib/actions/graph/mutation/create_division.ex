defmodule Actions.Graph.Mutation.CreateDivision do
  import Ecto.Changeset
  import U7406

  alias Actions.Graph.Mutation.DivisionFuncs.Create
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{tower_id: id, division: attrs} = args
    tower = Repo.get(Tower, id)

    attrs = Create.set_hash(attrs)

    division =
      build_assoc(tower, :divisions)
      |> create_division_changeset(attrs)
      |> Repo.insert!()

    {:ok, division}
  end

  def create_division_changeset(%Division{} = division, attrs) do
    division
    |> cast(attrs, [:name, :changed_at, :division_hash])
    |> validate_required([:name, :changed_at, :division_hash])
  end
end
