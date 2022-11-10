defmodule U7406.Repo.Migrations.CreateTowers do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration
  import U7406.MigrationsHelper

  def up do
    create table(:towers) do
      add :project_id, references(:projects, on_delete: :nothing), null: false
      add :tower_id, references(:towers, on_delete: :nothing), null: true
      add :name, :string, null: false
      add :public, :boolean, null: false, default: false
      add :inheritable, :boolean, null: false, default: true
      add :inherited_at, :utc_datetime_usec

      timestamps()
      soft_delete_columns()
    end

    create index(:towers, [:project_id])
    create index(:towers, [:tower_id])

    add_policies(:towers)
  end

  def down do
    drop table(:towers)
  end
end
