defmodule Schemas.Graph.SubGraphFilter do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.Result

  schema "sub_graph_filters" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division

    field :name, :string
    field :uid, :string
    field :changed_at, :utc_datetime_usec
    field :node_filter, :map
    field :edge_filter, :map

    timestamps()
    soft_delete_schema()

    has_many :results, Result, on_delete: :delete_all
  end
end
