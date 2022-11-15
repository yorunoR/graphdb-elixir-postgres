defmodule U7406.Repo.Migrations.CreateEdges do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:edges) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :edge_type_id, references(:edge_types, on_delete: :nothing), null: false
      add :rule_id, references(:rules, on_delete: :nothing), null: false
      add :start_node_type_id, references(:node_types, on_delete: :nothing), null: false
      add :start_node_id, references(:nodes, on_delete: :nothing), null: false
      add :end_node_type_id, references(:node_types, on_delete: :nothing), null: false
      add :end_node_id, references(:nodes, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :props, :map, default: "{}"
      add :random, :integer, null: false

      timestamps()
      soft_delete_columns()
    end

    create index(:edges, [:project_id])
    create index(:edges, [:tower_id])
    create index(:edges, [:division_id])
    create index(:edges, [:edge_type_id])
    create index(:edges, [:rule_id])
    create index(:edges, [:start_node_type_id])
    create index(:edges, [:start_node_id])
    create index(:edges, [:end_node_type_id])
    create index(:edges, [:end_node_id])

    create index(:edges, [:division_id, :random],
             unique: true,
             name: :edges_random_uniq_index
           )

    add_policies(:edges, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :edge_types, id: :edge_type_id},
      %{belongs_to: :rules, id: :rule_id},
      %{belongs_to: :node_types, id: :start_node_type_id},
      %{belongs_to: :nodes, id: :start_node_id},
      %{belongs_to: :node_types, id: :end_node_type_id},
      %{belongs_to: :nodes, id: :end_node_id}
    ])
  end

  def down do
    drop table(:edges)
  end
end
