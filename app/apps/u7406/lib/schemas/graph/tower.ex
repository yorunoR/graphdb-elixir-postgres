defmodule Schemas.Graph.Tower do
  use U7406.Schema
  import Ecto.SoftDelete.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Division
  alias Schemas.Graph.Tower

  schema "towers" do
    belongs_to :project, Project
    belongs_to :tower, Tower

    field :name, :string
    field :public, :boolean
    field :inheritable, :boolean
    field :inherited_at, :utc_datetime_usec

    timestamps()
    soft_delete_schema()

    has_many :divisions, Division, on_delete: :delete_all
  end
end
