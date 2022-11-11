defmodule U7406.Repo.Migrations.CreateAlgorithms do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:algorithms) do
      add :name, :string, null: false

      timestamps()
      soft_delete_columns()
    end
  end
end
