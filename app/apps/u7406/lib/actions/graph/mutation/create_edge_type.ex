defmodule Actions.Graph.Mutation.CreateEdgeType do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{edge_type: attrs, division_id: id} = args
    division = Repo.get(Division, id)

    edge_type =
      build_assoc(division, :edge_types)
      |> create_edge_type_changeset(attrs)
      |> Repo.insert!()

    {:ok, edge_type}
  end

  def create_edge_type_changeset(%EdgeType{} = edge_type, attrs) do
    edge_type
    |> cast(attrs, [:name, :uid])
    |> validate_required([:name, :uid])
  end
end
