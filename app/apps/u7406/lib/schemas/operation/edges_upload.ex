defmodule Schemas.Operation.EdgesUpload do
  use U7406.Schema

  alias Schemas.Account.Project
  alias Schemas.Graph.Tower
  alias Schemas.Graph.Division
  alias Schemas.Graph.EdgeType

  schema "edges_uploads" do
    belongs_to :project, Project
    belongs_to :tower, Tower
    belongs_to :division, Division
    belongs_to :edge_type, EdgeType

    field :content_type, :string
    field :name, :string
    field :object_path, :string
    field :target_count, :integer
    field :executed_count, :integer
    field :successed_count, :integer
    field :skipped_count, :integer
    field :failed_count, :integer
    field :status, Ecto.Enum, values: [CREATED: 0, STARTED: 1, COMPLETED: 2, ABORTED: 3]
    field :started_at, :utc_datetime_usec
    field :completed_at, :utc_datetime_usec
    field :aborted_at, :utc_datetime_usec
    field :last_executed_record, :map

    timestamps()
  end
end
