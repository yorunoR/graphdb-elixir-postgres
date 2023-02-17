defmodule Actions.Graph.Mutation.CreateEdge do
  alias Actions.Graph.Mixin.EdgeFuncs.Create
  alias Ecto.Multi
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Node
  alias U7406.Repo

  @max_range 1_000_000

  def run(_parent, args, _context) do
    %{edge: attrs} = args

    %{
      edge_type_id: edge_type_id,
      start_node_uid: start_node_uid,
      end_node_uid: end_node_uid,
      name: name,
      props: props
    } = attrs

    random = :rand.uniform(@max_range)

    edge_type = Repo.get!(EdgeType, edge_type_id)
    start_node = Repo.get_by!(Node, uid: start_node_uid)
    end_node = Repo.get_by!(Node, uid: end_node_uid)

    Multi.new()
    |> Multi.run(
      :check_rule,
      &Create.check_rule(&1, &2, edge_type, start_node, end_node)
    )
    |> Multi.run(
      :create_edge,
      &Create.create_edge(&1, &2, start_node, end_node, name, random, Utils.list_to_map(props))
    )
    |> Multi.run(
      :connect_edge,
      &Create.connect_edge(&1, &2, edge_type, start_node, end_node)
    )
    |> Repo.transaction()
    |> transaction_result()
  end

  def transaction_result({:ok, %{connect_edge: edge}}) do
    {:ok, edge}
  end

  def transaction_result({:error, _operation, error, _successes}) do
    {:error, error}
  end
end
