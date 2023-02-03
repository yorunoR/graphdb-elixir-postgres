defmodule Actions.Graph.Query.SubGraphData do
  alias Agents.Graph.SubGraphAgent
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args
    sub_graph_filter = Repo.get!(SubGraphFilter, id)

    {:ok, SubGraphAgent.sub_graph_data(sub_graph_filter)}
  end
end
