defmodule U7406.Repo.Migrations.CreateEdgeTypes do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:edge_types) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false

      timestamps()
      soft_delete_columns()
    end

    create index(:edge_types, [:project_id])
    create index(:edge_types, [:tower_id])
    create index(:edge_types, [:division_id])

    create index(:edge_types, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :edge_types_uid_uniq_index
           )

    add_policies(:edge_types, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id}
    ])
  end

  def down do
    drop table(:edge_types)
  end
end
