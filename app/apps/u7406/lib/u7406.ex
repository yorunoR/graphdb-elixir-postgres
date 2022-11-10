defmodule U7406 do
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.NodeType
  alias Schemas.Graph.Rule

  def build_assoc(%Division{} = division, :node_types) do
    attrs = %{project_id: division.project_id}
    Ecto.build_assoc(division, :node_types, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :node_fields) do
    attrs = %{
      project_id: node_type.project_id,
      division_id: node_type.division_id
    }

    Ecto.build_assoc(node_type, :node_fields, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :nodes) do
    attrs = %{
      project_id: node_type.project_id,
      division_id: node_type.division_id
    }

    Ecto.build_assoc(node_type, :nodes, attrs)
  end

  def build_assoc(%Division{} = division, :edge_types) do
    attrs = %{project_id: division.project_id}
    Ecto.build_assoc(division, :edge_types, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :edge_fields) do
    attrs = %{
      project_id: edge_type.project_id,
      division_id: edge_type.division_id
    }

    Ecto.build_assoc(edge_type, :edge_fields, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :rules) do
    attrs = %{
      project_id: edge_type.project_id,
      division_id: edge_type.division_id
    }

    Ecto.build_assoc(edge_type, :rules, attrs)
  end

  def build_assoc(%Rule{} = rule, :edges) do
    attrs = %{
      project_id: rule.project_id,
      division_id: rule.division_id,
      edge_type_id: rule.edge_type_id
    }

    Ecto.build_assoc(rule, :edges, attrs)
  end

  def build_assoc(%Division{} = division, :sub_graph_filters) do
    attrs = %{
      project_id: division.project_id,
      division_id: division.id
    }

    Ecto.build_assoc(division, :sub_graph_filters, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :nodes_upload_operations) do
    attrs = %{
      project_id: node_type.project_id,
      division_id: node_type.division_id,
      node_type_id: node_type.id
    }

    Ecto.build_assoc(node_type, :nodes_upload_operations, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :edges_upload_operations) do
    attrs = %{
      project_id: edge_type.project_id,
      division_id: edge_type.division_id,
      edge_type_id: edge_type.id
    }

    Ecto.build_assoc(edge_type, :edges_upload_operations, attrs)
  end

  def build_assoc(struct, assoc, attrs \\ %{}) do
    Ecto.build_assoc(struct, assoc, attrs)
  end

  def assoc(struct, assoc) do
    Ecto.assoc(struct, assoc)
  end
end
