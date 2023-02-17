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

import Ecto.Changeset
import U7406

alias Actions.Graph.Mixin.DivisionFuncs.Create
alias Schemas.Account.Project
alias Schemas.Graph.EdgeType
alias Schemas.Graph.NodeType
alias Schemas.Graph.Tower
alias U7406.Repo

Repo.as_admin(fn ->
  case Repo.get_by(Tower, name: "アニメ・漫画の実写映画化作品") do
    nil ->
      project = Repo.one(Project)

      tower =
        build_assoc(project, :towers)
        |> change(%{name: "アニメ・漫画の実写映画化作品"})
        |> Repo.insert!

      division =
        build_assoc(tower, :divisions)
        |> change(Create.set_hash(%{name: "映画と監督と主演"}))
        |> Repo.insert!

      node_type_list = [
        %{uid: "movie", name: "作品"},
        %{uid: "director", name: "監督"},
        %{uid: "actor", name: "俳優"}
      ]

      node_type_list
      |> Enum.each(fn attrs ->
        build_assoc(division, :node_types)
        |> change(attrs)
        |> Repo.insert!
      end)

      node_field_list = [
        %{uid: "actor", node_fields: [
          %{uid: "sex", name: "性別", type: :STRING}
        ]},
        %{uid: "movie", node_fields: [
          %{uid: "year", name: "公開年", type: :INTEGER}
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
        %{uid: "direction", name: "指揮"},
        %{uid: "starring", name: "主演"}
      ]

      edge_type_list
      |> Enum.each(fn attrs ->
        build_assoc(division, :edge_types)
        |> change(attrs)
        |> Repo.insert!
      end)

      rule_list = [
        %{uid: "direction", rules: [
          %{start_node_type_uid: "director", end_node_type_uid: "movie"}
        ]},
        %{uid: "starring", rules: [
          %{start_node_type_uid: "actor", end_node_type_uid: "movie"},
          %{start_node_type_uid: "movie", end_node_type_uid: "actor"}
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

      IO.inspect("store dev data")

    _ ->
      IO.inspect("already exist")
  end
end)
