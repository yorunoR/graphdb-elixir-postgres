defmodule Actions.Graph.Mutation.CreateDivision do
  import Ecto.Changeset
  import U7406

  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias U7406.Repo

  def run(_parent, args, _context) do
    %{tower_id: id, division: attrs} = args
    tower = Repo.get(Tower, id)

    now = DateTime.utc_now()
    datetime = Calendar.strftime(now, "_%y-%m-%d_%H:%M:%S")

    attrs =
      attrs
      |> Map.put(:changed_at, now)
      |> Map.put(:division_hash, sha256(attrs.name <> datetime))

    division =
      build_assoc(tower, :divisions)
      |> create_division_changeset(attrs)
      |> Repo.insert!()

    {:ok, division}
  end

  def create_division_changeset(%Division{} = division, attrs) do
    division
    |> cast(attrs, [:name, :changed_at, :division_hash])
    |> validate_required([:name, :changed_at, :division_hash])
  end

  def sha256(data) do
    :crypto.hash(:sha256, data) |> Base.encode16(case: :lower)
  end
end
