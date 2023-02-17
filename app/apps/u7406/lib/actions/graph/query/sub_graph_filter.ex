defmodule Actions.Graph.Query.SubGraphFilter do
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args

    {:ok, Repo.get(SubGraphFilter, id)}
  end
end
