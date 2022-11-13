defmodule Actions.Graph.CustomField.DivisionSummary do
  import U7406

  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(%Division{} = division, args, _context) do
    %{selections: selections} = args

    summary =
      selections
      |> Enum.reduce(%{}, fn selection, map ->
        case selection do
          "nodeTypeCount" ->
            Map.put(map, selection, assoc(division, :node_types) |> Repo.aggregate(:count))

          "edgeTypeCount" ->
            Map.put(map, selection, assoc(division, :edge_types) |> Repo.aggregate(:count))

          "nodeCount" ->
            Map.put(map, selection, assoc(division, :nodes) |> Repo.aggregate(:count))

          "edgeCount" ->
            Map.put(map, selection, assoc(division, :edges) |> Repo.aggregate(:count))

          _ ->
            map
        end
      end)

    {:ok, Utils.map_to_list(summary)}
  end
end
