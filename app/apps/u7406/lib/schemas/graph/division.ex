defmodule Schemas.Graph.Division do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Node
  alias Schemas.Graph.NodeType
  alias Schemas.Graph.Edge
  alias Schemas.Graph.EdgeType
  alias Schemas.Graph.Rule
  alias Schemas.Graph.SubGraphFilter
  # alias Schemas.Operation.NodesUpload

  schema "divisions" do
    belongs_to :project, Project
    belongs_to :tower, Tower

    field :name, :string
    field :division_hash, :string
    field :changed_at, :utc_datetime_usec

    timestamps()
    soft_delete_schema()

    has_many :node_types, NodeType, on_delete: :delete_all
    has_many :edge_types, EdgeType, on_delete: :delete_all
    has_many :rules, Rule, on_delete: :delete_all
    has_many :nodes, Node, on_delete: :delete_all
    has_many :edges, Edge, on_delete: :delete_all
    has_many :sub_graph_filters, SubGraphFilter, on_delete: :delete_all
    # has_many :nodes_uploads, NodesUpload, on_delete: :delete_all
  end
end
