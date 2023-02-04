defmodule Resolvers.GraphResolver do
  alias Actions.Graph.CustomField
  alias Actions.Graph.Mutation
  alias Actions.Graph.Query
  alias Schemas.Account.Project
  alias U7406.Repo

  def call(action, parent, args, %{context: context}) do
    case action do
      action when action in [:tower_summary, :division_summary] ->
        Repo.as_admin(fn ->
          run(action, parent, args, context)
        end)

      _ ->
        with %Project{} = project <- Map.get(context, :current_project) do
          Repo.as_user(project.id, fn ->
            run(action, parent, args, context)
          end)
        else
          _ -> {:error, "No current project"}
        end
    end
  end

  def admin_call(action, parent, args, %{context: context}) do
    Repo.as_admin(fn ->
      run(action, parent, args, context)
    end)
  end

  def run(action, parent, args, context) do
    case action do
      # CustomField
      :tower_summary ->
        CustomField.TowerSummary.run(parent, args, context)

      :division_summary ->
        CustomField.DivisionSummary.run(parent, args, context)

      # Query
      :tower ->
        Query.Tower.run(parent, args, context)

      :division ->
        Query.Division.run(parent, args, context)

      :sub_graph_filter ->
        Query.SubGraphFilter.run(parent, args, context)

      :nodes ->
        Query.Nodes.run(parent, args, context)

      :edges ->
        Query.Edges.run(parent, args, context)

      :node_bound_edges ->
        Query.NodeBoundEdges.run(parent, args, context)

      :sub_graph_data ->
        Query.SubGraphData.run(parent, args, context)

      :sub_graph_status ->
        Query.SubGraphStatus.run(parent, args, context)

      :libgraph_status ->
        Query.LibgraphStatus.run(parent, args, context)

      :sub_graph_command ->
        Query.SubGraphCommand.run(parent, args, context)

      :libgraph_command ->
        Query.LibgraphCommand.run(parent, args, context)

      # Mutation
      :create_tower ->
        Mutation.CreateTower.run(parent, args, context)

      :create_division ->
        Mutation.CreateDivision.run(parent, args, context)

      :create_node_type ->
        Mutation.CreateNodeType.run(parent, args, context)

      :update_node_type ->
        Mutation.UpdateNodeType.run(parent, args, context)

      :create_node_field ->
        Mutation.CreateNodeField.run(parent, args, context)

      :create_edge_type ->
        Mutation.CreateEdgeType.run(parent, args, context)

      :update_edge_type ->
        Mutation.UpdateEdgeType.run(parent, args, context)

      :create_edge_field ->
        Mutation.CreateEdgeField.run(parent, args, context)

      :create_rule ->
        Mutation.CreateRule.run(parent, args, context)

      :create_node ->
        Mutation.CreateNode.run(parent, args, context)

      :update_node ->
        Mutation.UpdateNode.run(parent, args, context)

      :create_edge ->
        Mutation.CreateEdge.run(parent, args, context)

      :update_edge ->
        Mutation.UpdateEdge.run(parent, args, context)

      :create_sub_graph_filter ->
        Mutation.CreateSubGraphFilter.run(parent, args, context)

      :update_sub_graph_filter ->
        Mutation.UpdateSubGraphFilter.run(parent, args, context)

      :start_sub_graph ->
        Mutation.StartSubGraph.run(parent, args, context)

      :stop_sub_graph ->
        Mutation.StopSubGraph.run(parent, args, context)

      :start_libgraph ->
        Mutation.StartLibgraph.run(parent, args, context)

      :stop_libgraph ->
        Mutation.StopLibgraph.run(parent, args, context)

      :create_result ->
        Mutation.CreateResult.run(parent, args, context)

      _ ->
        {:error, "Not defined in Graph context"}
    end
  end
end
