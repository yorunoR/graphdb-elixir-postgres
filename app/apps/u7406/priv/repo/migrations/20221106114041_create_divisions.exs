defmodule U7406.Repo.Migrations.CreateDivisions do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:divisions) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: false

      add :name, :string, null: false
      add :division_hash, :string, null: false
      add :changed_at, :utc_datetime_usec, null: false

      timestamps()
      soft_delete_columns()
    end

    create index(:divisions, [:project_id])
    create index(:divisions, [:tower_id])

    create index(:divisions, [:tower_id, :division_hash],
             unique: true,
             where: "deleted_at IS NULL",
             name: :divisions_division_hash_uniq_index
           )

    add_policies(:divisions, [
      %{belongs_to: :towers, id: :tower_id}
    ])
  end

  def down do
    drop table(:divisions)
  end
end
