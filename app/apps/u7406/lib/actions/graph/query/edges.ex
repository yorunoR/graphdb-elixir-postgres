defmodule Actions.Graph.Query.Edges do
  import U7406

  alias Queries.Graph
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{q: q, division_id: id, offset: offset, limit: limit} = args

    parameters = Jason.decode!(q)

    query =
      Repo.get(Division, id)
      |> assoc(:edges)
      |> Graph.join_assocs([:edge_type, :start_node, :end_node])
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
