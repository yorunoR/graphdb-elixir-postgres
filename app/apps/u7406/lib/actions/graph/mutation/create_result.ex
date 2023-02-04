defmodule Actions.Graph.Mutation.CreateResult do
  import Ecto.Changeset
  import U7406

  alias Schemas.Calc.Agency
  alias Schemas.Graph.Result
  alias Schemas.Graph.SubGraphFilter
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{sub_graph_filter_id: id, agency: agency, command: command, result: attrs} = args

    sub_graph_filter = Repo.get(SubGraphFilter, id)

    algorithm =
      Repo.get_by!(Agency, name: agency)
      |> assoc(:algorithms)
      |> Repo.all()
      |> Enum.find(fn alogorithm ->
        alogorithm.name == command
      end)

    result =
      build_assoc(sub_graph_filter, :results)
      |> change(%{agency_id: algorithm.agency_id, algorithm_id: algorithm.id})
      |> apply_changes
      |> create_result_changeset(attrs)
      |> Repo.insert!()

    {:ok, result}
  end

  def create_result_changeset(%Result{} = result, attrs) do
    result
    |> cast(attrs, [:name, :args, :opened_at, :division_changed_at, :sub_graph_filter_changed_at])
    |> validate_required([:opened_at, :division_changed_at, :sub_graph_filter_changed_at])
    |> put_change(:props, Utils.list_to_map(attrs.props))
  end
end
