defmodule U7406.Repo.Migrations.CreateSubGraphFilters do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:sub_graph_filters) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false
      add :changed_at, :utc_datetime_usec, null: false
      add :node_filter, :map, default: "{}"
      add :edge_filter, :map, default: "{}"

      timestamps()
      soft_delete_columns()
    end

    create index(:sub_graph_filters, [:project_id])
    create index(:sub_graph_filters, [:tower_id])
    create index(:sub_graph_filters, [:division_id])

    create index(:sub_graph_filters, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :sub_graph_filters_uid_uniq_index
           )

    add_policies(:sub_graph_filters, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id}
    ])
  end

  def down do
    drop table(:sub_graph_filters)
  end
end
