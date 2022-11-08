defmodule Schemas.Graph.Rule do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.NodeType
  alias Schemas.Graph.Edge

  schema "rules" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :edge_type, EdgeType
    belongs_to :start_node_type, NodeType
    belongs_to :end_node_type, NodeType

    field :name, :string
    field :uid, :string
    field :direction, Ecto.Enum, values: [UNIDIRECTION: 0, BIDIRECTION: 1]

    timestamps()
    soft_delete_schema()

    has_many :edges, Edge, on_delete: :delete_all
  end
end
