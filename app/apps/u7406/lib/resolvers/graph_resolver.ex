defmodule Resolvers.GraphResolver do
  alias Actions.Graph.CustomField
  alias Actions.Graph.Mutation
  alias Actions.Graph.Query
  alias Schemas.Account.Project
  alias Schemas.Account.ProjectUser
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
    privilege = get_privilege(context)

    case {action, privilege == 0} do
      # CustomField
      {:tower_summary, _} ->
        CustomField.TowerSummary.run(parent, args, context)

      {:division_summary, _} ->
        CustomField.DivisionSummary.run(parent, args, context)

      # Query
      {:tower, _} ->
        Query.Tower.run(parent, args, context)

      {:division, _} ->
        Query.Division.run(parent, args, context)

      {:sub_graph_filter, _} ->
        Query.SubGraphFilter.run(parent, args, context)

      {:nodes, _} ->
        Query.Nodes.run(parent, args, context)

      {:edges, _} ->
        Query.Edges.run(parent, args, context)

      {:node_bound_edges, _} ->
        Query.NodeBoundEdges.run(parent, args, context)

      {:sub_graph_data, _} ->
        Query.SubGraphData.run(parent, args, context)

      {:sub_graph_status, _} ->
        Query.SubGraphStatus.run(parent, args, context)

      {:libgraph_status, _} ->
        Query.LibgraphStatus.run(parent, args, context)

      {:sub_graph_command, _} ->
        Query.SubGraphCommand.run(parent, args, context)

      {:libgraph_command, _} ->
        Query.LibgraphCommand.run(parent, args, context)

      # Mutation
      {:create_tower, true} ->
        Mutation.CreateTower.run(parent, args, context)

      {:create_division, true} ->
        Mutation.CreateDivision.run(parent, args, context)

      {:create_node_type, true} ->
        Mutation.CreateNodeType.run(parent, args, context)

      {:update_node_type, true} ->
        Mutation.UpdateNodeType.run(parent, args, context)

      {:create_node_field, true} ->
        Mutation.CreateNodeField.run(parent, args, context)

      {:create_edge_type, true} ->
        Mutation.CreateEdgeType.run(parent, args, context)

      {:update_edge_type, true} ->
        Mutation.UpdateEdgeType.run(parent, args, context)

      {:create_edge_field, true} ->
        Mutation.CreateEdgeField.run(parent, args, context)

      {:create_rule, true} ->
        Mutation.CreateRule.run(parent, args, context)

      {:create_node, true} ->
        Mutation.CreateNode.run(parent, args, context)

      {:update_node, true} ->
        Mutation.UpdateNode.run(parent, args, context)

      {:create_edge, true} ->
        Mutation.CreateEdge.run(parent, args, context)

      {:update_edge, true} ->
        Mutation.UpdateEdge.run(parent, args, context)

      {:create_sub_graph_filter, true} ->
        Mutation.CreateSubGraphFilter.run(parent, args, context)

      {:update_sub_graph_filter, true} ->
        Mutation.UpdateSubGraphFilter.run(parent, args, context)

      {:start_sub_graph, true} ->
        Mutation.StartSubGraph.run(parent, args, context)

      {:stop_sub_graph, true} ->
        Mutation.StopSubGraph.run(parent, args, context)

      {:start_libgraph, true} ->
        Mutation.StartLibgraph.run(parent, args, context)

      {:stop_libgraph, true} ->
        Mutation.StopLibgraph.run(parent, args, context)

      {:create_result, true} ->
        Mutation.CreateResult.run(parent, args, context)

      {_, _} ->
        {:error, "Not defined in Graph context"}
    end
  end

  def get_privilege(%{} = context) do
    user = Map.get(context, :current_user)
    project = Map.get(context, :current_project)

    project_user = Repo.get_by!(ProjectUser, user_id: user.id, project_id: project.id)
    project_user.privilege
  end

  def get_privilege(_) do
    nil
  end
end
