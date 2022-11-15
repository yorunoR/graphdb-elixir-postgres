defmodule Actions.Graph.Mutation.UpdateEdge do
  import Ecto.Changeset

  alias Schemas.Graph.Edge
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{edge: attrs, edge_id: id} = args
    edge = Repo.get(Edge, id)

    edge =
      edge
      |> update_edge_changeset(attrs)
      |> Repo.update!()

    {:ok, edge}
  end

  def update_edge_changeset(%Edge{} = edge, attrs) do
    edge
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_change(:props, Utils.list_to_map(attrs.props))
  end
end
