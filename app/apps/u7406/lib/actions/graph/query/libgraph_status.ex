defmodule Actions.Graph.Query.LibgraphStatus do
  alias Agents.Graph.LibgraphAgent
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args
    sub_graph_filter = Repo.get!(SubGraphFilter, id)

    LibgraphAgent.libgraph_status(sub_graph_filter)
  end
end
