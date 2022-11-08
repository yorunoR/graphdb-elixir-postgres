defmodule Schemas.Graph.Result do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.SubGraphFilter
  alias Schemas.Calc.Algorithm

  schema "results" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :sub_graph_filter, SubGraphFilter
    belongs_to :algorithm, Algorithm

    field :name, :string
    field :division_hash, :string
    field :opened_at, :utc_datetime_usec
    field :props, :map

    timestamps()
    soft_delete_schema()
  end
end
