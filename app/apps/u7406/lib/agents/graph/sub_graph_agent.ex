defmodule Agents.Graph.SubGraphAgent do
  defstruct [:nodes, :edges, :opened_at, :sub_graph_filter_id]

  use Agent
  import U7406

  alias __MODULE__
  alias Queries.GraphQuery
  alias Schemas.Calc.Agency
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
              |> GraphQuery.join_assocs([:node_type])
              |> GraphQuery.search(node_parameters)

            nodes = nodes_query |> Repo.all()

            edges_query =
              Repo.get(Division, sub_graph_filter.division_id)
              |> assoc(:edges)
              |> GraphQuery.join_assocs([:edge_type])
              |> GraphQuery.join_bind_assocs([:start_node, :end_node], nodes_query)
              |> GraphQuery.search(edge_parameters)

            edges = edges_query |> Repo.all()

            %SubGraphAgent{
              nodes: nodes,
              edges: edges,
              opened_at: DateTime.utc_now(),
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
    commands = Repo.get_by!(Agency, name: "SubGraph") |> assoc(:algorithms) |> Repo.all()

    case Process.whereis(name) do
      nil ->
        {:ok, %{status: false, opened_at: nil, commands: commands}}

      _ ->
        status = Agent.get(name, & &1)

        {:ok,
         %{
           status: true,
           opened_at: status.opened_at,
           commands: commands
         }}
    end
  end

  def sub_graph_command(sub_graph_filter, command, opts \\ []) do
    name = String.to_atom("SubGraph:" <> Integer.to_string(sub_graph_filter.id))

    case Process.whereis(name) do
      nil -> {:error, "Process stopped"}
      _ -> Agent.get(name, run(command, opts))
    end
  end

  def run("node_count", _opts) do
    fn state -> %{node_count: state.nodes |> length} end
  end

  def run("edge_count", _opts) do
    fn state -> %{edge_count: state.edges |> length} end
  end

  def run(_command, _opts) do
    fn _state -> {:error, "Command not Found"} end
  end
end
