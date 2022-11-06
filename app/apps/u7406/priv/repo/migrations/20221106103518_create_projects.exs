defmodule U7406.Repo.Migrations.CreateProjects do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:projects) do
      add :default, :boolean, null: false, default: false
      add :name, :string, null: false

      timestamps()
      soft_delete_columns()
    end
  end
end
