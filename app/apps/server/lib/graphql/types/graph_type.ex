defmodule Graphql.Types.GraphType do
  use Absinthe.Schema.Notation

  alias Resolvers.GraphResolver

  object :graph_queries do
    field(:tower, :tower) do
      arg(:tower_id, non_null(:id))
      resolve(&GraphResolver.call(:tower, &1, &2, &3))
    end

    field(:division, :division) do
      arg(:division_id, non_null(:id))
      resolve(&GraphResolver.call(:division, &1, &2, &3))
    end

    # field(:sub_graph_filter, :sub_graph_filter) do
    #   arg(:sub_graph_filter_id, non_null(:id))
    #   resolve(&GraphResolver.call(:sub_graph_filter, &1, &2, &3))
    # end
  end

  object :graph_mutations do
    field(:create_tower, :tower) do
      arg(:tower, non_null(:input_tower))
      resolve(&GraphResolver.call(:create_tower, &1, &2, &3))
    end

    field(:create_division, :division) do
      arg(:tower_id, non_null(:id))
      arg(:division, non_null(:input_division))
      resolve(&GraphResolver.call(:create_division, &1, &2, &3))
    end

    # field(:create_node_type, :node_type) do
    #   arg(:division_id, non_null(:id))
    #   arg(:node_type, non_null(:input_node_type))
    #   resolve(&GraphResolver.call(:create_node_type, &1, &2, &3))
    # end

    # field(:update_node_type, :node_type) do
    #   arg(:node_type_id, non_null(:id))
    #   arg(:node_type, non_null(:input_node_type))
    #   resolve(&GraphResolver.call(:update_node_type, &1, &2, &3))
    # end

    # field(:create_node_field, :node_field) do
    #   arg(:node_type_id, non_null(:id))
    #   arg(:node_field, non_null(:input_node_field))
    #   resolve(&GraphResolver.call(:create_node_field, &1, &2, &3))
    # end

    # field(:create_edge_type, :edge_type) do
    #   arg(:division_id, non_null(:id))
    #   arg(:edge_type, non_null(:input_edge_type))
    #   resolve(&GraphResolver.call(:create_edge_type, &1, &2, &3))
    # end

    # field(:update_edge_type, :edge_type) do
    #   arg(:edge_type_id, non_null(:id))
    #   arg(:edge_type, non_null(:input_edge_type))
    #   resolve(&GraphResolver.call(:update_edge_type, &1, &2, &3))
    # end

    # field(:create_edge_field, :edge_field) do
    #   arg(:edge_type_id, non_null(:id))
    #   arg(:edge_field, non_null(:input_edge_field))
    #   resolve(&GraphResolver.call(:create_edge_field, &1, &2, &3))
    # end

    # field(:create_rule, :rule) do
    #   arg(:edge_type_id, non_null(:id))
    #   arg(:rule, non_null(:input_rule))
    #   resolve(&GraphResolver.call(:create_rule, &1, &2, &3))
    # end

    # field(:create_node, :node) do
    #   arg(:node, non_null(:input_node))
    #   resolve(&GraphResolver.call(:create_node, &1, &2, &3))
    # end

    # field(:update_node, :node) do
    #   arg(:node_id, non_null(:id))
    #   arg(:node, non_null(:input_node))
    #   resolve(&GraphResolver.call(:update_node, &1, &2, &3))
    # end

    # field(:create_edge, :edge) do
    #   arg(:edge, non_null(:input_edge))
    #   resolve(&GraphResolver.call(:create_edge, &1, &2, &3))
    # end

    # field(:update_edge, :edge) do
    #   arg(:edge_id, non_null(:id))
    #   arg(:edge, non_null(:input_edge))
    #   resolve(&GraphResolver.call(:update_edge, &1, &2, &3))
    # end

    # field(:create_sub_graph_filter, :sub_graph_filter) do
    #   arg(:division_id, non_null(:id))
    #   arg(:sub_graph_filter, non_null(:input_sub_graph_filter))
    #   resolve(&GraphResolver.call(:create_sub_graph_filter, &1, &2, &3))
    # end

    # field(:update_sub_graph_filter, :sub_graph_filter) do
    #   arg(:sub_graph_filter_id, non_null(:id))
    #   arg(:sub_graph_filter, non_null(:input_sub_graph_filter))
    #   resolve(&GraphResolver.call(:update_sub_graph_filter, &1, &2, &3))
    # end
  end
end
