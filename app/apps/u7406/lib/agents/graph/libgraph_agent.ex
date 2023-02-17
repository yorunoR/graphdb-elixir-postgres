defmodule Agents.Graph.LibgraphAgent do
  defstruct [
    :graph,
    :opened_at,
    :division_changed_at,
    :sub_graph_filter_changed_at,
    :sub_graph_filter_id
  ]

  use Agent
  import U7406

  alias __MODULE__
  alias Queries.GraphQuery
  alias Schemas.Calc.Agency
  alias Schemas.Graph.Division
  alias U7406.Repo

  def start_libgraph(sub_graph_filter) do
    name = String.to_atom("Libgraph:" <> Integer.to_string(sub_graph_filter.id))
    node_parameters = Map.get(sub_graph_filter.node_filter, "q", [])
    edge_parameters = Map.get(sub_graph_filter.edge_filter, "q", [])

    result =
      Agent.start_link(
        fn ->
          Repo.as_admin(fn ->
            division = Repo.get(Division, sub_graph_filter.division_id)

            nodes_query =
              division
              |> assoc(:nodes)
              |> GraphQuery.join_assocs([:node_type])
              |> GraphQuery.search(node_parameters)

            g = Graph.new()

            g =
              nodes_query
              |> Repo.stream()
              |> Enum.reduce(g, fn node, g ->
                Graph.add_vertex(g, node.uid)
              end)

            edges_query =
              division
              |> assoc(:edges)
              |> GraphQuery.join_assocs([:edge_type])
              |> GraphQuery.join_bind_assocs([:start_node, :end_node], nodes_query)
              |> GraphQuery.search(edge_parameters)

            g =
              edges_query
              |> Repo.stream()
              |> Enum.reduce(g, fn edge, g ->
                edge = edge |> Repo.preload([:start_node, :end_node, :edge_type])

                Graph.add_edge(g, edge.start_node.uid, edge.end_node.uid,
                  label: edge.edge_type.uid
                )
              end)

            %LibgraphAgent{
              graph: g,
              opened_at: DateTime.utc_now(),
              division_changed_at: division.changed_at,
              sub_graph_filter_changed_at: sub_graph_filter.changed_at,
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

  def stop_libgraph(sub_graph_filter) do
    name = String.to_atom("Libgraph:" <> Integer.to_string(sub_graph_filter.id))

    case Process.whereis(name) do
      nil ->
        {:ok, %{status: false}}

      _ ->
        Agent.stop(name)
        {:ok, %{status: true}}
    end
  end

  def libgraph_status(sub_graph_filter, division) do
    name = String.to_atom("Libgraph:" <> Integer.to_string(sub_graph_filter.id))
    commands = Repo.get_by!(Agency, name: "Libgraph") |> assoc(:algorithms) |> Repo.all()

    case Process.whereis(name) do
      nil ->
        {:ok, %{status: false, opened_at: nil, commands: commands}}

      _ ->
        status = Agent.get(name, & &1)

        {:ok,
         %{
           status: true,
           opened_at: status.opened_at,
           division_changed_at: status.division_changed_at,
           sub_graph_filter_changed_at: status.sub_graph_filter_changed_at,
           current_division_changed_at: division.changed_at,
           current_sub_graph_filter_changed_at: sub_graph_filter.changed_at,
           commands: commands
         }}
    end
  end

  def libgraph_command(sub_graph_filter, command, opts \\ []) do
    name = String.to_atom("Libgraph:" <> Integer.to_string(sub_graph_filter.id))

    case Process.whereis(name) do
      nil -> {:error, "Process stopped"}
      _ -> Agent.get(name, run(command, opts))
    end
  end

  def run("info", _opts) do
    fn state -> Graph.info(state.graph) end
  end

  def run("vertices", _opts) do
    fn state -> Graph.vertices(state.graph) end
  end

  def run("get_shortest_path", opts) do
    [first | [second | _]] = opts

    fn state -> Graph.get_shortest_path(state.graph, first, second) end
  end

  def run(_command, _opts) do
    fn _state -> {:error, "Command not Found"} end
  end
end
