defmodule Schemas.Graph.EdgeType do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.Rule
  alias Schemas.Graph.EdgeField
  alias Schemas.Graph.Edge
  # alias Schemas.Operation.EdgesUpload

  schema "edge_types" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division

    field :name, :string
    field :uid, :string

    timestamps()
    soft_delete_schema()

    has_many :rules, Rule, on_delete: :delete_all
    has_many :edge_fields, EdgeField, on_delete: :delete_all
    has_many :edges, Edge, on_delete: :delete_all
    # has_many :edges_uploads, EdgesUpload, on_delete: :delete_all
  end
end
