defmodule Actions.Graph.Mutation.UpdateNodeType do
  import Ecto.Changeset

  alias Schemas.Graph.NodeType
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{node_type: attrs, node_type_id: id} = args
    node_type = Repo.get(NodeType, id)

    node_type =
      node_type
      |> update_node_type_changeset(attrs)
      |> Repo.update!()

    {:ok, node_type}
  end

  def update_node_type_changeset(%NodeType{} = node_type, attrs) do
    node_type
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
