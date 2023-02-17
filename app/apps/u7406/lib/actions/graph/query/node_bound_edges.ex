defmodule Actions.Graph.Query.NodeBoundEdges do
  import U7406

  alias Queries.GraphQuery
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{q: q, q_node: q_node, division_id: id, offset: offset, limit: limit} = args

    parameters = Jason.decode!(q)
    node_parameters = Jason.decode!(q_node)

    sub_query =
      Repo.get(Division, id)
      |> assoc(:nodes)
      |> GraphQuery.join_assocs([:node_type])
      |> GraphQuery.search(node_parameters)

    query =
      Repo.get(Division, id)
      |> assoc(:edges)
      |> GraphQuery.join_assocs([:edge_type])
      |> GraphQuery.join_bind_assocs([:start_node, :end_node], sub_query)
      |> GraphQuery.search(parameters)

    edges = query |> GraphQuery.paginate(offset, limit) |> Repo.all()
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
