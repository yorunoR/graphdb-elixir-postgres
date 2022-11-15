defmodule Actions.Graph.Mutation.UpdateSubGraphFilter do
  import Ecto.Changeset

  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter: attrs, sub_graph_filter_id: id} = args
    sub_graph_filter = Repo.get(SubGraphFilter, id)

    sub_graph_filter =
      sub_graph_filter
      |> update_sub_graph_filter_changeset(attrs)
      |> Repo.update!()

    {:ok, sub_graph_filter}
  end

  def update_sub_graph_filter_changeset(%SubGraphFilter{} = sub_graph_filter, attrs) do
    sub_graph_filter
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
