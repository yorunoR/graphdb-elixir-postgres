defmodule Actions.Graph.Query.SubGraphStatus do
  alias Agents.Graph.SubGraphAgent
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args
    sub_graph_filter = Repo.get!(SubGraphFilter, id)

    SubGraphAgent.sub_graph_status(sub_graph_filter)
  end
end
