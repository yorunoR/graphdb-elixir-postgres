# Script for populating the database. You can run it as:
#
#     mix run priv/repo/store_for_dev.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     U7406.Repo.insert!(%U7406.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
require Integer

import Ecto.Changeset
import U7406

alias Actions.Graph.Mixin.EdgeFuncs
alias Actions.Graph.Mixin.DivisionFuncs
alias Schemas.Account.Project
alias Schemas.Graph.EdgeType
alias Schemas.Graph.NodeType
alias Schemas.Graph.Node
alias Schemas.Graph.Rule
alias Schemas.Graph.Tower
alias U7406.Repo

Repo.as_admin(fn ->
  case Repo.get_by(Tower, name: "検証用構造体") do
    nil ->
      project = Repo.one(Project)

      tower =
        build_assoc(project, :towers)
        |> change(%{name: "検証用構造体"})
        |> Repo.insert!

      division =
        build_assoc(tower, :divisions)
        |> change(DivisionFuncs.Create.set_hash(%{name: "Random graph"}))
        |> Repo.insert!

      node_type_list = [
        %{uid: "vertex", name: "頂点"},
      ]

      node_type_list
      |> Enum.each(fn attrs ->
        build_assoc(division, :node_types)
        |> change(attrs)
        |> Repo.insert!
      end)

      node_field_list = [
        %{uid: "vertex", node_fields: [
          %{uid: "label", name: "ラベル", type: :STRING}
        ]},
      ]

      node_field_list
      |> Enum.each(fn params ->
        node_type = Repo.get_by!(NodeType, uid: params.uid)

        params.node_fields
        |> Enum.each(fn attrs ->
          build_assoc(node_type, :node_fields)
          |> change(attrs)
          |> Repo.insert!
        end)
      end)

      edge_type_list = [
        %{uid: "line", name: "辺"},
      ]

      edge_type_list
      |> Enum.each(fn attrs ->
        build_assoc(division, :edge_types)
        |> change(attrs)
        |> Repo.insert!
      end)

      rule_list = [
        %{uid: "line", rules: [
          %{start_node_type_uid: "vertex", end_node_type_uid: "vertex"}
        ]},
      ]

      rule_list
      |> Enum.each(fn params ->
        edge_type = Repo.get_by!(EdgeType, uid: params.uid)

        params.rules
        |> Enum.each(fn rule ->
          start_node_type = Repo.get_by!(NodeType, uid: rule.start_node_type_uid)
          end_node_type = Repo.get_by!(NodeType, uid: rule.end_node_type_uid)
          attrs = %{
            start_node_type_id: start_node_type.id,
            end_node_type_id: end_node_type.id,
            name: edge_type.name
          }

          build_assoc(edge_type, :rules)
          |> change(attrs)
          |> Repo.insert!
        end)
      end)

      node_type = Repo.one(NodeType)
      rule = Repo.one(Rule)
      edge_type = Repo.one(EdgeType)
      limit = 100

      Enum.each(1..limit, fn i ->
        label = to_string(i)
        random = :rand.uniform(1_000_000)

        build_assoc(node_type, :nodes)
        |> change(%{uid: label, name: label, random: i})
        |> Repo.insert!
      end)

      for(n <- 1..limit, m <- (n + 1)..limit) do
        if Enum.random([1, 2, 3, 4, 5, 6, 7, 8]) == 1, do: [n, m], else: nil
      end
      |> Enum.reject(&is_nil/1)
      |> Enum.each(fn [n, m] ->
        start_node = Repo.get_by!(Node, uid: to_string(n))
        end_node = Repo.get_by!(Node, uid: to_string(m))
        edge = EdgeFuncs.Create.do_create_edge(Repo, rule, start_node, end_node, "#{n}-#{m}", n*limit + m, %{})
        EdgeFuncs.Create.do_connect_edge(Repo, edge, edge_type, start_node, end_node)
      end)

      IO.inspect("store random data")

    _ ->
      IO.inspect("already exist")
  end
end)
