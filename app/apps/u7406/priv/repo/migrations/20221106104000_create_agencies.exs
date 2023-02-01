defmodule U7406.Repo.Migrations.CreateAgencies do
  use Ecto.Migration
  import Ecto.SoftDelete.Migration

  def change do
    create table(:agencies) do
      add :name, :string, null: false

      timestamps()
      soft_delete_columns()
    end
  end
end
