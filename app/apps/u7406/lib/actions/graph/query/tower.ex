defmodule Actions.Graph.Query.Tower do
  alias Schemas.Graph.Tower
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{tower_id: id} = args

    {:ok, Repo.get(Tower, id)}
  end
end
