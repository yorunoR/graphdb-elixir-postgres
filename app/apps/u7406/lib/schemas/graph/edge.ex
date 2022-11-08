defmodule Schemas.Graph.Edge do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Rule
  alias Schemas.Graph.NodeType
  alias Schemas.Graph.Node

  schema "edges" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :edge_type, EdgeType
    belongs_to :rule, Rule
    belongs_to :start_node_type, NodeType
    belongs_to :start_node, Node
    belongs_to :end_node_type, NodeType
    belongs_to :end_node, Node

    field :name, :string
    field :props, :map
    field :rondom, :integer

    timestamps()
    soft_delete_schema()
  end
end
