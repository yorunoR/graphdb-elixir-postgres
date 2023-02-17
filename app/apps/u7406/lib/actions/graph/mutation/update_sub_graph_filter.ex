defmodule Actions.Graph.Mutation.UpdateSubGraphFilter do
  import Ecto.Changeset

  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id} = args
    attrs = args |> Map.get(:sub_graph_filter, %{})
    sub_graph_filter = Repo.get(SubGraphFilter, id)

    q_node = check_filter(args, :q_node, sub_graph_filter.node_filter)
    q_edge = check_filter(args, :q_edge, sub_graph_filter.edge_filter)

    sub_graph_filter =
      sub_graph_filter
      |> update_sub_graph_filter_changeset(attrs, q_node, q_edge)
      |> Repo.update!()

    {:ok, sub_graph_filter}
  end

  def update_sub_graph_filter_changeset(
        %SubGraphFilter{} = sub_graph_filter,
        attrs,
        q_node,
        q_edge
      ) do
    sub_graph_filter
    |> cast(attrs, [:name])
    |> put_filter(:node_filter, q_node)
    |> put_filter(:edge_filter, q_edge)
  end

  def put_filter(changeset, _filter, nil) do
    changeset
  end

  def put_filter(changeset, filter, q) do
    parameters = Jason.decode!(q)
    now = DateTime.utc_now()

    changeset
    |> put_change(filter, %{q: parameters, version: "1.0"})
    |> put_change(:changed_at, now)
  end

  def check_filter(args, field, privious_filter) do
    previous_val = privious_filter |> Map.get("q", []) |> Jason.encode!()

    case Map.get(args, field, nil) do
      nil -> nil
      ^previous_val -> nil
      val -> val
    end
  end
end
