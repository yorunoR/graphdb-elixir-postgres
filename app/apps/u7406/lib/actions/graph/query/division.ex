defmodule Actions.Graph.Query.Division do
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{division_id: id} = args

    {:ok, Repo.get(Division, id)}
  end
end
