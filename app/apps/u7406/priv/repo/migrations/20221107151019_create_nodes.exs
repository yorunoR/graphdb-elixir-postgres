defmodule U7406.Repo.Migrations.CreateNodes do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:nodes) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :node_type_id, references(:node_types, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false
      add :edge_ids_map, :boolean, null: false, default: true
      add :start_edge_ids, :map, default: "{}"
      add :end_edge_ids, :map, default: "{}"
      add :props, :map, default: "{}"
      add :rondom, :integer, null: false

      timestamps()
      soft_delete_columns()
    end

    create index(:nodes, [:project_id])
    create index(:nodes, [:tower_id])
    create index(:nodes, [:division_id])
    create index(:nodes, [:node_type_id])

    create index(:nodes, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :nodes_uid_uniq_index
           )

    create index(:nodes, [:division_id, :rondom],
             unique: true,
             name: :nodes_rondom_uniq_index
           )

    add_policies(:nodes, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :node_types, id: :node_type_id}
    ])
  end

  def down do
    drop table(:nodes)
  end
end
