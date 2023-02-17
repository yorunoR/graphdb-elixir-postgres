defmodule Actions.Graph.Mutation.CreateEdgeField do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.EdgeField
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{edge_field: attrs, edge_type_id: id} = args
    edge_type = Repo.get(EdgeType, id)

    edge_field =
      build_assoc(edge_type, :edge_fields)
      |> create_edge_field_changeset(attrs)
      |> Repo.insert!()

    {:ok, edge_field}
  end

  def create_edge_field_changeset(%EdgeField{} = edge_field, attrs) do
    edge_field
    |> cast(attrs, [:name, :type, :uid])
    |> validate_required([:name, :type, :uid])
  end
end
