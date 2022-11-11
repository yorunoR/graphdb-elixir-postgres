defmodule Schemas.Graph.NodeType do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.NodeField
  alias Schemas.Graph.Node
  # alias Schemas.Operation.NodesUpload

  schema "node_types" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division

    field :name, :string
    field :uid, :string

    timestamps()
    soft_delete_schema()

    has_many :node_fields, NodeField, on_delete: :delete_all
    has_many :nodes, Node, on_delete: :delete_all
    # has_many :nodes_uploads, NodesUpload, on_delete: :delete_all
  end
end
