defmodule Actions.Graph.Mixin.EdgeFuncs.Create do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Node
  alias Schemas.Graph.Rule

  def check_rule(repo, _run, %EdgeType{} = edge_type, %Node{} = start_node, %Node{} = end_node) do
    rule =
      assoc(edge_type, :rules)
      |> repo.get_by(
        start_node_type_id: start_node.node_type_id,
        end_node_type_id: end_node.node_type_id
      )

    case rule do
      %Rule{} -> {:ok, rule}
      _ -> {:error, %{message: "no rules", code: :not_found}}
    end
  end

  def create_edge(repo, run, %Node{} = start_node, %Node{} = end_node, name, random, %{} = props) do
    %{check_rule: rule} = run

    attrs = %{
      start_node_id: start_node.id,
      start_node_type_id: start_node.node_type_id,
      end_node_id: end_node.id,
      end_node_type_id: end_node.node_type_id,
      name: name,
      random: random,
      props: props
    }

    edge =
      build_assoc(rule, :edges)
      |> change(attrs)
      |> unique_constraint([:divieion_id, :uid], name: :edges_uid_uniq_index)
      |> unique_constraint([:divieion_id, :random], name: :edges_random_uniq_index)
      |> repo.insert!

    {:ok, edge}
  end

  def connect_edge(repo, run, edge_type, start_node, end_node) do
    %{create_edge: edge} = run

    start_edge_ids = Map.get(start_node.start_edge_ids, edge_type.uid, [])
    start_edge_ids = Map.put(start_node.start_edge_ids, edge_type.uid, [edge.id | start_edge_ids])

    start_node |> change(%{start_edge_ids: start_edge_ids}) |> repo.update!()

    end_edge_ids = Map.get(end_node.end_edge_ids, edge_type.uid, [])
    end_edge_ids = Map.put(end_node.end_edge_ids, edge_type.uid, [edge.id | end_edge_ids])

    end_node |> change(%{end_edge_ids: end_edge_ids}) |> repo.update!()

    {:ok, edge}
  end
end
