defmodule Actions.Graph.Mutation.CreateNodeType do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Division
  alias Schemas.Graph.NodeType
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{node_type: attrs, division_id: id} = args
    division = Repo.get(Division, id)

    node_type =
      build_assoc(division, :node_types)
      |> create_node_type_changeset(attrs)
      |> Repo.insert!()

    {:ok, node_type}
  end

  def create_node_type_changeset(%NodeType{} = node_type, attrs) do
    node_type
    |> cast(attrs, [:name, :uid])
    |> validate_required([:name, :uid])
  end
end
