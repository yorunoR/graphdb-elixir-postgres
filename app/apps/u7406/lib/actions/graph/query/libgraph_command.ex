defmodule Actions.Graph.Query.LibgraphCommand do
  alias Agents.Graph.LibgraphAgent
  alias Schemas.Graph.Result
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id, command: command} = args
    opts = Map.get(args, :opts)
    sub_graph_filter = Repo.get!(SubGraphFilter, id)

    result = LibgraphAgent.libgraph_command(sub_graph_filter, command, opts)

    {:ok,
     %Result{
       props: result
     }}
  end
end
