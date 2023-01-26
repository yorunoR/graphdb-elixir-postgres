defmodule Actions.Graph.Query.Nodes do
  import U7406

  alias Queries.GraphQuery
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{q: q, division_id: id, offset: offset, limit: limit} = args

    parameters = Jason.decode!(q)

    query =
      Repo.get(Division, id)
      |> assoc(:nodes)
      |> GraphQuery.join_assocs([:node_type])
      |> GraphQuery.search(parameters)

    nodes = query |> GraphQuery.paginate(offset, limit) |> Repo.all()
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
