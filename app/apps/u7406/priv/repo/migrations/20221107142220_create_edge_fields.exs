defmodule U7406.Repo.Migrations.CreateEdgeFields do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def change do
    create table(:edge_fields) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false
      add :division_id, references(:divisions, on_delete: :nothing), null: false
      add :edge_type_id, references(:edge_types, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :uid, :string, null: false
      add :type, :integer, null: false
      add :disabled, :boolean, null: false, default: false

      timestamps()
      soft_delete_columns()
    end

    create index(:edge_fields, [:project_id])
    create index(:edge_fields, [:tower_id])
    create index(:edge_fields, [:division_id])
    create index(:edge_fields, [:edge_type_id])

    create index(:edge_fields, [:division_id, :uid],
             unique: true,
             where: "deleted_at IS NULL",
             name: :edge_fields_uid_uniq_index
           )

    add_policies(:edge_fields, [
      %{belongs_to: :towers, id: :tower_id},
      %{belongs_to: :divisions, id: :division_id},
      %{belongs_to: :edge_types, id: :edge_type_id}
    ])
  end
end
