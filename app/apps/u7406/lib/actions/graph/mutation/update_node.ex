defmodule Actions.Graph.Mutation.UpdateNode do
  import Ecto.Changeset

  alias Schemas.Graph.Node
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{node: attrs, node_id: id} = args
    node = Repo.get(Node, id)

    node =
      node
      |> update_node_changeset(attrs)
      |> Repo.update!()

    {:ok, node}
  end

  def update_node_changeset(%Node{} = node, attrs) do
    node
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> put_change(:props, Utils.list_to_map(attrs.props))
  end
end
