defmodule Actions.Graph.Query.NodeBoundEdges do
  import U7406

  alias Queries.Graph
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{q: q, q_node: q_node, division_id: id, offset: offset, limit: limit} = args

    parameters = Jason.decode!(q)
    node_parameters = Jason.decode!(q_node)

    sub_query =
      Repo.get(Division, id)
      |> assoc(:nodes)
      |> Graph.join_assocs([:node_type])
      |> Graph.search(node_parameters)

    query =
      Repo.get(Division, id)
      |> assoc(:edges)
      |> Graph.join_assocs([:edge_type])
      |> Graph.join_bind_assocs([:start_node, :end_node], sub_query)
      |> Graph.search(parameters)

    edges = query |> Graph.paginate(offset, limit) |> Repo.all()
    total = query |> Repo.aggregate(:count)

    {:ok,
     %{
       entries: edges,
       offset: offset,
       limit: limit,
       total: total
     }}
  end
end
