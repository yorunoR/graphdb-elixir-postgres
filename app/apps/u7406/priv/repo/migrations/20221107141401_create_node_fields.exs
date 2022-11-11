defmodule U7406.Repo.Migrations.CreateNodeFields do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:node_fields) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :node_type_id, references(:node_types, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false
      add :type, :integer, null: false
      add :disabled, :boolean, null: false, default: false

      timestamps()
      soft_delete_columns()
    end

    create index(:node_fields, [:project_id])
    create index(:node_fields, [:tower_id])
    create index(:node_fields, [:division_id])
    create index(:node_fields, [:node_type_id])

    create index(:node_fields, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :node_fields_uid_uniq_index
           )

    add_policies(:node_fields, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :node_types, id: :node_type_id}
    ])
  end

  def down do
    drop table(:node_fields)
  end
end
