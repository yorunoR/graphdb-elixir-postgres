defmodule Schemas.Graph.Node do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.NodeType

  schema "nodes" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :node_type, NodeType

    field :name, :string
    field :uid, :string
    field :edge_ids_map, :boolean
    field :start_edge_ids, :map
    field :end_edge_ids, :map
    field :props, :map
    field :random, :integer

    timestamps()
    soft_delete_schema()
  end
end
