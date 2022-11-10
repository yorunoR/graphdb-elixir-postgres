defmodule U7406.Repo.Migrations.CreateResults do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:results) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :sub_graph_filter_id, references(:sub_graph_filters, on_delete: :nothing), null: false
      add :algorithm_id, references(:algorithms, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :division_hash, :string, null: false
      add :opened_at, :utc_datetime_usec, null: false
      add :props, :map, default: "{}"

      timestamps()
      soft_delete_columns()
    end

    create index(:results, [:project_id])
    create index(:results, [:tower_id])
    create index(:results, [:division_id])
    create index(:results, [:sub_graph_filter_id])
    create index(:results, [:algorithm_id])

    add_policies(:results, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :sub_graph_filters, id: :sub_graph_filter_id}
    ])
  end

  def down do
    drop table(:results)
  end
end
