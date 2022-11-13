defmodule Actions.Graph.Mutation.UpdateEdgeType do
  import Ecto.Changeset

  alias Schemas.Graph.EdgeType
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{edge_type: attrs, edge_type_id: id} = args
    edge_type = Repo.get(EdgeType, id)

    edge_type =
      edge_type
      |> update_edge_type_changeset(attrs)
      |> Repo.update!()

    {:ok, edge_type}
  end

  def update_edge_type_changeset(%EdgeType{} = edge_type, attrs) do
    edge_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
