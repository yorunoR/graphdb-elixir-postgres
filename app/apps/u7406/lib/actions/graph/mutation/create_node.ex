defmodule Actions.Graph.Mutation.CreateNode do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Node
  alias Schemas.Graph.NodeType
  alias U7406.Repo

  @max_range 1_000_000

  def run(_parent, args, _context) do
    %{node: attrs} = args
    %{node_type_id: id} = attrs
    node_type = Repo.get(NodeType, id)

    attrs = Map.put(attrs, :random, :rand.uniform(@max_range))

    node =
      build_assoc(node_type, :nodes)
      |> create_node_changeset(attrs)
      |> Repo.insert!()

    {:ok, node}
  end

  def create_node_changeset(%Node{} = node, attrs) do
    node
    |> cast(attrs, [:name, :uid, :random])
    |> validate_required([:name, :uid, :random])
    |> put_change(:props, Utils.list_to_map(attrs.props))
  end
end
