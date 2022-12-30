defmodule Agents.Graph.SubGraphAgent do
  defstruct nodes: [], edges: []

  use Agent
  import U7406

  alias __MODULE__
  alias Queries.Graph
  alias Schemas.Graph.Division
  alias U7406.Repo

  def start_sub_graph(sub_graph_filter) do
    name = String.to_atom("SubGraph:" <> Integer.to_string(sub_graph_filter.id))
    node_parameters = Map.get(sub_graph_filter.node_filter, "q", [])
    edge_parameters = Map.get(sub_graph_filter.edge_filter, "q", [])

    result =
      Agent.start_link(
        fn ->
          Repo.as_admin(fn ->
            nodes_query =
              Repo.get(Division, sub_graph_filter.division_id)
              |> assoc(:nodes)
              |> Graph.join_assocs([:node_type])
              |> Graph.search(node_parameters)

            nodes = nodes_query |> Repo.all()

            edges_query =
              Repo.get(Division, sub_graph_filter.division_id)
              |> assoc(:edges)
              |> Graph.join_assocs([:edge_type])
              |> Graph.join_bind_assocs([:start_node, :end_node], nodes_query)
              |> Graph.search(edge_parameters)

            edges = edges_query |> Repo.all()

            %{
              sub_graph: %SubGraphAgent{nodes: nodes, edges: edges},
              opend_at: DateTime.utc_now(),
              sub_graph_filter_id: sub_graph_filter.id
            }
          end)
        end,
        name: name
      )

    case result do
      {:ok, _pid} -> {:ok, %{status: true}}
      _ -> {:ok, %{status: false}}
    end
  end

  def stop_sub_graph(sub_graph_filter) do
    name = String.to_atom("SubGraph:" <> Integer.to_string(sub_graph_filter.id))

    case Process.whereis(name) do
      nil ->
        {:ok, %{status: false}}

      _ ->
        Agent.stop(name)
        {:ok, %{status: true}}
    end
  end

  def sub_graph_status(sub_graph_filter) do
    name = String.to_atom("SubGraph:" <> Integer.to_string(sub_graph_filter.id))
    node_parameters = Map.get(sub_graph_filter.node_filter, "q", [])
    edge_parameters = Map.get(sub_graph_filter.edge_filter, "q", [])

    nodes_query =
      Repo.get(Division, sub_graph_filter.division_id)
      |> assoc(:nodes)
      |> Graph.join_assocs([:node_type])
      |> Graph.search(node_parameters)

    nodes = nodes_query |> Repo.aggregate(:count)

    edges_query =
      Repo.get(Division, sub_graph_filter.division_id)
      |> assoc(:edges)
      |> Graph.join_assocs([:edge_type])
      |> Graph.join_bind_assocs([:start_node, :end_node], nodes_query)
      |> Graph.search(edge_parameters)

    edges = edges_query |> Repo.aggregate(:count)

    case Process.whereis(name) do
      nil ->
        {:ok,
         %{status: false, nodes: nodes, edges: edges, changed_at: sub_graph_filter.changed_at}}

      _ ->
        {:ok,
         %{status: true, nodes: nodes, edges: edges, changed_at: sub_graph_filter.changed_at}}
    end
  end

  # def calc_depth_first_search(agent_name, node) do
  #   algorithm = Calc.get_algorithm_by_name!("DepthFirstSearch")

  #   %{sub_graph_filter_id: sub_graph_filter_id, opened_at: opened_at} =
  #     get_sub_graph_filter_id_and_opend_at(agent_name)

  #   sub_graph_filter = Api.SubGraphFilter.get_sub_graph_filter!(sub_graph_filter_id)

  #   Agent.update(
  #     agent_name,
  #     fn %{sub_graph: sub_graph} = status ->
  #       Repo.as_admin(fn ->
  #         depth_first_search = Calc.DepthFirstSearch.calc(sub_graph, node)

  #         Api.Result.create_result(sub_graph_filter, %{
  #           opend_at: opened_at,
  #           props: %{
  #             color: depth_first_search.color,
  #             pred: depth_first_search.pred,
  #             start_uid: depth_first_search.start_uid
  #           },
  #           algorithm_id: algorithm.id
  #         })

  #         Map.merge(status, %{depth_first_search: depth_first_search})
  #       end)
  #     end,
  #     :infinity
  #   )
  # end

  # defp get_sub_graph_filter_id_and_opend_at(agent_name) do
  #   Agent.get(agent_name, &%{sub_graph_filter_id: &1.sub_graph_filter_id, opened_at: &1.opend_at})
  # end
end
