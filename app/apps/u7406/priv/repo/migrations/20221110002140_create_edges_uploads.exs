defmodule U7406.Repo.Migrations.CreateEdgesUploads do
  use Ecto.Migration
  import U7406.MigrationsHelper

  def change do
    create table(:edges_uploads) do
      add :project_id, references(:projects, on_delete: :nothing)
      add :tower_id, references(:towers, on_delete: :nothing)
      add :division_id, references(:divisions, on_delete: :nothing)
      add :edge_type_id, references(:edge_types, on_delete: :nothing)

      add :content_type, :string
      add :name, :string
      add :object_path, :string
      add :target_count, :integer
      add :executed_count, :integer
      add :successed_count, :integer
      add :skipped_count, :integer
      add :failed_count, :integer
      add :status, :integer, default: 0
      add :started_at, :utc_datetime_usec
      add :completed_at, :utc_datetime_usec
      add :aborted_at, :utc_datetime_usec
      add :last_executed_record, :map

      timestamps()
    end

    create index(:edges_uploads, [:project_id])
    create index(:edges_uploads, [:tower_id])
    create index(:edges_uploads, [:division_id])
    create index(:edges_uploads, [:edge_type_id])

    add_policies(:edges_uploads, [
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :edge_types, id: :edge_type_id}
    ])
  end
end
