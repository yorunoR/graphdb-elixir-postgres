defmodule Actions.Graph.Mutation.CreateNodeField do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.NodeType
  alias Schemas.Graph.NodeField
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{node_field: attrs, node_type_id: id} = args
    node_type = Repo.get(NodeType, id)

    node_field =
      build_assoc(node_type, :node_fields)
      |> create_node_field_changeset(attrs)
      |> Repo.insert!()

    {:ok, node_field}
  end

  def create_node_field_changeset(%NodeField{} = node_field, attrs) do
    node_field
    |> cast(attrs, [:name, :type, :uid])
    |> validate_required([:name, :type, :uid])
  end
end
