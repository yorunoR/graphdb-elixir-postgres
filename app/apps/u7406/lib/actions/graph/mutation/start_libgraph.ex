defmodule Actions.Graph.Mutation.StartLibgraph do
  alias Agents.Graph.LibgraphAgent
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args

    sub_graph_filter = Repo.get!(SubGraphFilter, id)
    LibgraphAgent.start_libgraph(sub_graph_filter)
  end
end
