defmodule U7406.Repo.Migrations.CreateRules do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def change do
    create table(:rules) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :edge_type_id, references(:edge_types, on_delete: :nothing), null: false
      add :start_node_type_id, references(:node_types, on_delete: :nothing), null: false
      add :end_node_type_id, references(:node_types, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false
      add :direction, :integer, null: false, default: 0

      timestamps()
      soft_delete_columns()
    end

    create index(:rules, [:project_id])
    create index(:rules, [:tower_id])
    create index(:rules, [:division_id])
    create index(:rules, [:edge_type_id])
    create index(:rules, [:start_node_type_id])
    create index(:rules, [:end_node_type_id])

    create index(:rules, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :rules_uid_uniq_index
           )

    add_policies(:rules, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :edge_types, id: :edge_type_id},
      %{belongs_to: :node_types, id: :start_node_type_id},
      %{belongs_to: :node_types, id: :end_node_type_id}
    ])
  end
end
