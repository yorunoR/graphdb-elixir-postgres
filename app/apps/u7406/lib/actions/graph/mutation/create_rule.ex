defmodule Actions.Graph.Mutation.CreateRule do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Rule
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{rule: attrs, edge_type_id: id} = args
    edge_type = Repo.get(EdgeType, id)

    rule =
      build_assoc(edge_type, :rules)
      |> create_rule_changeset(attrs)
      |> Repo.insert!()

    {:ok, rule}
  end

  def create_rule_changeset(%Rule{} = rule, attrs) do
    rule
    |> cast(attrs, [:name, :start_node_type_id, :end_node_type_id])
    |> validate_required([:name, :start_node_type_id, :end_node_type_id])
  end
end
