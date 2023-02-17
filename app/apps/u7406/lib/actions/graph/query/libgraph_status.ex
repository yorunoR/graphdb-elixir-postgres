defmodule Actions.Graph.Query.LibgraphStatus do
  alias Agents.Graph.LibgraphAgent
  alias Schemas.Graph.Division
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args
    sub_graph_filter = Repo.get!(SubGraphFilter, id)
    division = Repo.get!(Division, sub_graph_filter.division_id)

    LibgraphAgent.libgraph_status(sub_graph_filter, division)
  end
end
