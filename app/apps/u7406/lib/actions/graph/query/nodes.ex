defmodule Actions.Graph.Query.Nodes do
  import U7406

  alias Queries.Graph
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{q: q, division_id: id, offset: offset, limit: limit} = args

    parameters = Jason.decode!(q)

    query =
      Repo.get(Division, id)
      |> assoc(:nodes)
      |> Graph.join_assocs([:node_type])
      |> Graph.search(parameters)

    nodes = query |> Graph.paginate(offset, limit) |> Repo.all()
    total = query |> Repo.aggregate(:count)

    {:ok,
     %{
       entries: nodes,
       offset: offset,
       limit: limit,
       total: total
     }}
  end
end
