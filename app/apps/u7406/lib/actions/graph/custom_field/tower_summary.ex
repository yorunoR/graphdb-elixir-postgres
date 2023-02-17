defmodule Actions.Graph.CustomField.TowerSummary do
  import U7406

  alias Schemas.Graph.Tower
  alias U7406.Repo

  def run(%Tower{} = tower, args, _context) do
    %{selections: selections} = args

    summary =
      selections
      |> Enum.reduce(%{}, fn selection, map ->
        case selection do
          "divisionCount" ->
            Map.put(map, selection, assoc(tower, :divisions) |> Repo.aggregate(:count))

          _ ->
            map
        end
      end)

    {:ok, Utils.map_to_list(summary)}
  end
end
