defmodule U7406 do
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.NodeType
  alias Schemas.Graph.Rule
  alias Schemas.Graph.SubGraphFilter

  def build_assoc(%Tower{} = tower, :divisions) do
    attrs = %{project_id: tower.project_id}
    Ecto.build_assoc(tower, :divisions, attrs)
  end

  def build_assoc(%Division{} = division, :node_types) do
    attrs = %{
      project_id: division.project_id,
      tower_id: division.tower_id
    }

    Ecto.build_assoc(division, :node_types, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :node_fields) do
    attrs = %{
      project_id: node_type.project_id,
      tower_id: node_type.tower_id,
      division_id: node_type.division_id
    }

    Ecto.build_assoc(node_type, :node_fields, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :nodes) do
    attrs = %{
      project_id: node_type.project_id,
      tower_id: node_type.tower_id,
      division_id: node_type.division_id
    }

    Ecto.build_assoc(node_type, :nodes, attrs)
  end

  def build_assoc(%Division{} = division, :edge_types) do
    attrs = %{
      project_id: division.project_id,
      tower_id: division.tower_id
    }

    Ecto.build_assoc(division, :edge_types, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :edge_fields) do
    attrs = %{
      project_id: edge_type.project_id,
      tower_id: edge_type.tower_id,
      division_id: edge_type.division_id
    }

    Ecto.build_assoc(edge_type, :edge_fields, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :rules) do
    attrs = %{
      project_id: edge_type.project_id,
      tower_id: edge_type.tower_id,
      division_id: edge_type.division_id
    }

    Ecto.build_assoc(edge_type, :rules, attrs)
  end

  def build_assoc(%Rule{} = rule, :edges) do
    attrs = %{
      project_id: rule.project_id,
      tower_id: rule.tower_id,
      division_id: rule.division_id,
      edge_type_id: rule.edge_type_id
    }

    Ecto.build_assoc(rule, :edges, attrs)
  end

  def build_assoc(%Division{} = division, :sub_graph_filters) do
    attrs = %{
      project_id: division.project_id,
      tower_id: division.tower_id
    }

    Ecto.build_assoc(division, :sub_graph_filters, attrs)
  end

  def build_assoc(%NodeType{} = node_type, :nodes_uploads) do
    attrs = %{
      project_id: node_type.project_id,
      tower_id: node_type.tower_id,
      division_id: node_type.division_id
    }

    Ecto.build_assoc(node_type, :nodes_uploads, attrs)
  end

  def build_assoc(%EdgeType{} = edge_type, :edges_uploads) do
    attrs = %{
      project_id: edge_type.project_id,
      tower_id: edge_type.tower_id,
      division_id: edge_type.division_id
    }

    Ecto.build_assoc(edge_type, :edges_uploads, attrs)
  end

  def build_assoc(%SubGraphFilter{} = sub_graph_filter, :results) do
    attrs = %{
      project_id: sub_graph_filter.project_id,
      tower_id: sub_graph_filter.tower_id,
      division_id: sub_graph_filter.division_id
    }

    Ecto.build_assoc(sub_graph_filter, :results, attrs)
  end

  def build_assoc(struct, assoc, attrs \\ %{}) do
    Ecto.build_assoc(struct, assoc, attrs)
  end

  def assoc(struct, assoc) do
    Ecto.assoc(struct, assoc)
  end
end
