defmodule Schemas.Graph.EdgeField do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType

  schema "edge_fields" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :edge_type, EdgeType

    field :name, :string
    field :uid, :string
    field :type, Ecto.Enum, values: [STRING: 1, INTEGER: 2, DATETIME: 3]
    field :disabled, :boolean

    timestamps()
    soft_delete_schema()
  end
end
