defmodule U7406.Repo.Migrations.CreateAlgorithms do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:algorithms) do
      add :agency_id, references(:agencies, on_delete: :nothing), null: false
      add :name, :string, null: false
      add :arity, :integer, null: false, default: 0
      add :description, :text
      add :drawable, :boolean, default: false

      timestamps()
      soft_delete_columns()
    end
  end
end
