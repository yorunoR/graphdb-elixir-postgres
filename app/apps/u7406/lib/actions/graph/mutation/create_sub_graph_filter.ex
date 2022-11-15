defmodule Actions.Graph.Mutation.CreateSubGraphFilter do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Division
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter: attrs, division_id: id} = args
    division = Repo.get(Division, id)

    sub_graph_filter =
      build_assoc(division, :sub_graph_filters)
      |> create_sub_graph_filter_changeset(attrs)
      |> Repo.insert!()

    {:ok, sub_graph_filter}
  end

  def create_sub_graph_filter_changeset(%SubGraphFilter{} = sub_graph_filter, attrs) do
    sub_graph_filter
    |> cast(attrs, [:name, :uid])
    |> validate_required([:name, :uid])
  end
end
